return function(c, o)
	return vim.tbl_extend("force", require("themer.highlights.default.plugins.oil")(c, o), {
		OilDir = { fg = c.bright_cyan, bold = true },
		OilDirIcon = { fg = c.bright_cyan },
		OilLink = { fg = c.blue },
		OilSocket = { fg = c.bright_magenta },
	})
end
