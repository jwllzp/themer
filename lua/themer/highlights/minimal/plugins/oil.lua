return function(c, o)
	return vim.tbl_extend("force", require("themer.highlights.default.plugins.oil")(c, o), {
		OilDir = { fg = c.cyan, bold = true },
		OilDirIcon = { fg = c.cyan },
	})
end
