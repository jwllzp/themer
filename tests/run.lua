-- Headless smoke tests. Run from the repo root:
--   nvim --headless -u NONE -i NONE --cmd "set rtp^=." -l tests/run.lua
vim.opt.rtp:prepend(".")
vim.o.termguicolors = true

-- Isolated cache so tests never touch the user's.
local tmp = vim.fn.tempname()
local utils = require("themer.utils")
utils.cache_dir = tmp

local themer = require("themer")
local failures, passed = 0, 0

local function check(name, fn)
	local ok, err = pcall(fn)
	if ok then
		passed = passed + 1
	else
		failures = failures + 1
		io.stdout:write("FAIL " .. name .. "\n  " .. tostring(err) .. "\n")
	end
end

local function hex(n)
	return n and string.format("#%06X", n) or nil
end

local function hl(name)
	return vim.api.nvim_get_hl(0, { name = name, link = false })
end

local palettes, variants = utils.list("palettes"), utils.list("highlights")
assert(#palettes > 0 and #variants > 0, "no palettes or variants found")

for _, p in ipairs(palettes) do
	check("palette " .. p .. " is valid base24", function()
		local pal = require("themer.palettes." .. p)
		assert(pal.name == p, "name field must match filename")
		assert(pal.variant == "dark" or pal.variant == "light", "variant must be dark|light")
		for _, slot in ipairs(utils.slots) do
			assert(utils.is_hex(pal[slot]), slot .. " is not #RRGGBB: " .. tostring(pal[slot]))
		end
	end)
end

for _, p in ipairs(palettes) do
	local pal = require("themer.palettes." .. p)
	for _, v in ipairs(variants) do
		local id = p .. "/" .. v

		check(id .. " loads", function()
			themer.setup({ palette_variant = p, highlights_variant = v })
			vim.cmd.colorscheme("themer")
			assert(vim.g.colors_name == "themer", "colors_name not set")
			local normal = hl("Normal")
			assert(hex(normal.fg) == pal.base05:upper(), "Normal fg " .. tostring(hex(normal.fg)))
			assert(hex(normal.bg) == pal.base00:upper(), "Normal bg " .. tostring(hex(normal.bg)))
			assert(vim.g.terminal_color_0 == pal.base00, "terminal colors not set")
			for _, g in ipairs({ "TelescopeMatching", "GitSignsAdd", "RainbowDelimiterRed", "OilDir" }) do
				assert(next(hl(g)), g .. " missing")
			end
		end)

		check(id .. " every group resolves", function()
			for name, spec in pairs(themer.build()) do
				if spec.link then
					assert(next(hl(name)) or name:match("^@lsp"), name .. " links to undefined " .. spec.link)
				end
				for _, key in ipairs({ "fg", "bg", "sp" }) do
					local val = spec[key]
					assert(val == nil or val == "NONE" or utils.is_hex(val), name .. "." .. key .. " = " .. tostring(val))
				end
			end
		end)

		check(id .. " transparent", function()
			themer.setup({ palette_variant = p, highlights_variant = v, transparent = true })
			vim.cmd.colorscheme("themer")
			assert(hl("Normal").bg == nil, "Normal bg should be unset")
			assert(hl("NormalFloat").bg == nil, "NormalFloat bg should be unset")
		end)
	end
end

check("styles are applied and overridable", function()
	themer.setup({ highlights_variant = "semantic", styles = { keywords = { bold = false, italic = true } } })
	vim.cmd.colorscheme("themer")
	local kw = hl("Keyword")
	assert(kw.italic and not kw.bold, vim.inspect(kw))
	assert(not hl("Comment").italic, "comments not italic by default")
	assert(hl("@keyword.return").italic, "linked group inherits style")
end)

check("unknown variant reports error", function()
	local msgs = {}
	local notify = vim.notify
	vim.notify = function(m)
		msgs[#msgs + 1] = m
	end
	themer.setup({ palette_variant = "nope" })
	themer.load()
	vim.notify = notify
	assert(msgs[1] and msgs[1]:match("available"), "expected error, got " .. vim.inspect(msgs))
end)

check("cache hit, then invalidated by config change", function()
	themer.setup({})
	vim.cmd.colorscheme("themer")
	local path = utils.cache_path(require("themer.config").options)
	local before = vim.uv.fs_stat(path).mtime

	local compile, calls = themer.compile, 0
	themer.compile = function(...)
		calls = calls + 1
		return compile(...)
	end
	vim.cmd.colorscheme("themer")
	assert(calls == 0, "expected cache hit")
	themer.setup({ transparent = true })
	vim.cmd.colorscheme("themer")
	assert(calls == 1, "expected rebuild after config change")
	themer.compile = compile
	assert(before, "cache file existed")
end)

vim.fn.delete(tmp, "rf")
io.stdout:write(string.format("%d passed, %d failed\n", passed, failures))
os.exit(failures == 0 and 0 or 1)
