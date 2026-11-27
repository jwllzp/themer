return function(c, o)
	local u = require("themer.utils")
	return vim.tbl_extend("force", require("themer.highlights.default.plugins.telescope")(c, o), {
		TelescopeBorder = { fg = u.blend(c.fg_dim, c.bg, 0.4), bg = o.transparent and c.none or c.bg_dark },
		TelescopePromptBorder = { fg = u.blend(c.fg_dim, c.bg, 0.4), bg = o.transparent and c.none or c.bg_dark },
		TelescopeTitle = { fg = c.fg_bright, bold = true },
		TelescopePromptTitle = { fg = c.fg_bright, bold = true },
		TelescopeResultsTitle = { fg = c.fg_bright, bold = true },
		TelescopePreviewTitle = { fg = c.fg_bright, bold = true },
		TelescopePromptPrefix = { fg = c.magenta },
		TelescopeSelection = { bg = c.surface },
		TelescopeSelectionCaret = { fg = c.blue, bg = c.surface },
		TelescopeMatching = { fg = c.bright_yellow, bold = true },
	})
end
