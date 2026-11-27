return function(c, o)
	-- Xcode uses neutral grey for diff markers and red only for conflicts/deletions.
	return vim.tbl_extend("force", require("themer.highlights.default.plugins.gitsigns")(c, o), {
		GitSignsAdd = { fg = c.bright_green },
		GitSignsChange = { fg = c.fg_dim },
		GitSignsDelete = { fg = c.bright_red },
	})
end
