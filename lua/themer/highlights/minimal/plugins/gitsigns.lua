return function(c, o)
	return vim.tbl_extend("force", require("themer.highlights.default.plugins.gitsigns")(c, o), {
		GitSignsChange = { fg = c.cyan },
	})
end
