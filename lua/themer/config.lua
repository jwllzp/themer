local M = {}

M.defaults = {
	-- Remove backgrounds from Normal, floats, sign/number columns and plugin windows.
	transparent = false,
	-- Palette file in lua/themer/palettes/<name>.lua (all palettes are base24).
	palette_variant = "xcode_dark",
	-- Highlight mapping in lua/themer/highlights/<name>/: "minimal" | "default" | "semantic".
	highlights_variant = "default",
	-- Text styles merged into the matching highlight groups (any nvim_set_hl attrs).
	styles = {
		comments = {},
		keywords = { bold = true },
		functions = {},
		variables = {},
		strings = {},
	},
	-- Highlight groups for external plugins.
	integrations = {
		telescope = true,
		gitsigns = true,
		rainbow_delimiters = true,
		oil = true,
	},
}

M.options = vim.deepcopy(M.defaults)

function M.set(opts)
	M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
	return M.options
end

return M
