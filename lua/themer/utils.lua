local M = {}

local uv = vim.uv or vim.loop

-- Absolute path of lua/themer/.
M.root = vim.fs.dirname(debug.getinfo(1, "S").source:sub(2))
M.cache_dir = vim.fn.stdpath("cache") .. "/themer"

M.slots = {
	"base00",
	"base01",
	"base02",
	"base03",
	"base04",
	"base05",
	"base06",
	"base07",
	"base08",
	"base09",
	"base0A",
	"base0B",
	"base0C",
	"base0D",
	"base0E",
	"base0F",
	"base10",
	"base11",
	"base12",
	"base13",
	"base14",
	"base15",
	"base16",
	"base17",
}

-- Readable names for base24 slots, usable in highlight files.
M.aliases = {
	bg = "base00",
	bg_alt = "base01",
	surface = "base02",
	comment = "base03",
	fg_dim = "base04",
	fg = "base05",
	fg_light = "base06",
	fg_bright = "base07",
	red = "base08",
	orange = "base09",
	yellow = "base0A",
	green = "base0B",
	cyan = "base0C",
	blue = "base0D",
	magenta = "base0E",
	brown = "base0F",
	bg_dark = "base10",
	bg_darker = "base11",
	bright_red = "base12",
	bright_yellow = "base13",
	bright_green = "base14",
	bright_cyan = "base15",
	bright_blue = "base16",
	bright_magenta = "base17",
}

-- ── colors ──────────────────────────────────────────────────────────────────

local function rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

--- Mix `fg` over `bg`; alpha 1 = fg, 0 = bg.
function M.blend(fg, bg, alpha)
	local r1, g1, b1 = rgb(fg)
	local r2, g2, b2 = rgb(bg)
	local function mix(a, b)
		return math.floor(math.min(math.max(a * alpha + b * (1 - alpha), 0), 255) + 0.5)
	end
	return string.format("#%02X%02X%02X", mix(r1, r2), mix(g1, g2), mix(b1, b2))
end

function M.darken(hex, amount)
	return M.blend(hex, "#000000", 1 - amount)
end

function M.lighten(hex, amount)
	return M.blend(hex, "#FFFFFF", 1 - amount)
end

function M.is_hex(v)
	return type(v) == "string" and v:match("^#%x%x%x%x%x%x$") ~= nil
end

-- ── discovery ───────────────────────────────────────────────────────────────

function M.list(kind)
	local names = {}
	for name, type in vim.fs.dir(M.root .. "/" .. kind) do
		if kind == "palettes" and type == "file" and name:match("%.lua$") then
			names[#names + 1] = name:gsub("%.lua$", "")
		elseif kind == "highlights" and type == "directory" then
			names[#names + 1] = name
		end
	end
	table.sort(names)
	return names
end

function M.exists(kind, name)
	return vim.tbl_contains(M.list(kind), name)
end

-- Drop cached modules so edits to palettes/highlights are picked up on recompile.
function M.unload()
	for mod in pairs(package.loaded) do
		if mod:match("^themer%.palettes%.") or mod:match("^themer%.highlights%.") then
			package.loaded[mod] = nil
		end
	end
end

function M.resolve_palette(name)
	local p = vim.deepcopy(require("themer.palettes." .. name))
	for alias, slot in pairs(M.aliases) do
		p[alias] = p[slot]
	end
	p.none = "NONE"
	return p
end

-- ── cache ───────────────────────────────────────────────────────────────────

-- Signature of every source file so editing a palette or highlight file invalidates the cache.
local function source_signature()
	local parts = {}
	for path, type in vim.fs.dir(M.root, { depth = 10 }) do
		if type == "file" then
			local stat = uv.fs_stat(M.root .. "/" .. path)
			if stat then
				parts[#parts + 1] = path .. ":" .. stat.mtime.sec .. "." .. stat.mtime.nsec .. ":" .. stat.size
			end
		end
	end
	table.sort(parts)
	return table.concat(parts, ";")
end

function M.hash(config)
	return vim.fn.sha256(vim.inspect(config) .. source_signature())
end

function M.cache_path(config)
	return M.cache_dir .. "/" .. config.palette_variant .. "-" .. config.highlights_variant
end

local function read(path)
	local f = io.open(path, "rb")
	if not f then
		return nil
	end
	local data = f:read("*a")
	f:close()
	return data
end

local function write(path, data)
	local f = assert(io.open(path, "wb"))
	f:write(data)
	f:close()
end

function M.cache_valid(path, hash)
	return read(path .. ".hash") == hash and uv.fs_stat(path) ~= nil
end

--- Serialize highlights into a bytecode chunk at `path`.
function M.compile(path, hash, groups, meta)
	local inline = { newline = "", indent = "" }
	local lines = {
		"local h = vim.api.nvim_set_hl",
		string.format("vim.o.background = %q", meta.background),
		'vim.g.colors_name = "themer"',
	}
	local names = vim.tbl_keys(groups)
	table.sort(names)
	for _, name in ipairs(names) do
		lines[#lines + 1] = string.format("h(0, %q, %s)", name, vim.inspect(groups[name], inline))
	end
	for i, color in ipairs(meta.terminal) do
		lines[#lines + 1] = string.format("vim.g.terminal_color_%d = %q", i - 1, color)
	end

	local chunk = assert(load(table.concat(lines, "\n"), "=themer"))
	vim.fn.mkdir(vim.fs.dirname(path), "p")
	write(path, string.dump(chunk, true))
	write(path .. ".hash", hash)
end

return M
