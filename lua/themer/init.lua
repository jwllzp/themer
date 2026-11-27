local config = require("themer.config")
local utils = require("themer.utils")

local M = {}

local modules = { "editor", "syntax", "treesitter", "lsp", "semantic_tokens" }

-- Which groups each `styles` category is merged into (Lua patterns).
local style_targets = {
	comments = { "^Comment$", "^SpecialComment$", "^@comment" },
	keywords = { "^Keyword$", "^Statement$", "^Conditional$", "^Repeat$", "^Exception$", "^@keyword" },
	functions = { "^Function$", "^@function", "^@lsp%.type%.function$", "^@lsp%.type%.method$" },
	variables = { "^Identifier$", "^@variable", "^@lsp%.type%.variable$", "^@lsp%.type%.parameter$" },
	strings = { "^String$", "^@string" },
}

local function apply_styles(groups, styles)
	for category, patterns in pairs(style_targets) do
		local style = styles[category]
		if style and next(style) then
			for name, spec in pairs(groups) do
				-- Linked groups inherit the style from their target.
				if not spec.link then
					for _, pat in ipairs(patterns) do
						if name:match(pat) then
							groups[name] = vim.tbl_extend("force", spec, style)
							break
						end
					end
				end
			end
		end
	end
end

local function validate(cfg)
	for key, kind in pairs({ palette_variant = "palettes", highlights_variant = "highlights" }) do
		if not utils.exists(kind, cfg[key]) then
			vim.notify(
				string.format("themer: unknown %s %q (available: %s)", key, cfg[key], table.concat(utils.list(kind), ", ")),
				vim.log.levels.ERROR
			)
			return false
		end
	end
	return true
end

function M.setup(opts)
	config.set(opts)
end

--- Build highlight groups for `cfg` without applying them.
function M.build(cfg)
	cfg = cfg or config.options
	utils.unload()
	local c = utils.resolve_palette(cfg.palette_variant)
	local prefix = "themer.highlights." .. cfg.highlights_variant .. "."

	local groups = {}
	local function add(mod)
		groups = vim.tbl_extend("force", groups, require(mod)(c, cfg))
	end
	for _, name in ipairs(modules) do
		add(prefix .. name)
	end
	for name, enabled in pairs(cfg.integrations) do
		if enabled then
			local ok, err = pcall(add, prefix .. "plugins." .. name)
			if not ok then
				vim.notify("themer: integration " .. name .. ": " .. err, vim.log.levels.WARN)
			end
		end
	end
	apply_styles(groups, cfg.styles)

	local terminal = {}
	for _, slot in ipairs({
		"base00", "base08", "base0B", "base0A", "base0D", "base0E", "base0C", "base05",
		"base03", "base12", "base14", "base13", "base16", "base17", "base15", "base07",
	}) do
		terminal[#terminal + 1] = c[slot]
	end
	return groups, { background = c.variant or "dark", terminal = terminal }
end

--- Rebuild the cache for the current config. Returns the cache path.
function M.compile()
	local cfg = config.options
	local path = utils.cache_path(cfg)
	local groups, meta = M.build(cfg)
	utils.compile(path, utils.hash(cfg), groups, meta)
	return path
end

function M.load()
	local cfg = config.options
	if not validate(cfg) then
		return
	end
	if vim.g.colors_name then
		vim.cmd("hi clear")
	end

	local path = utils.cache_path(cfg)
	if not utils.cache_valid(path, utils.hash(cfg)) then
		M.compile()
	end
	dofile(path)
end

return M
