local u = require("themer.utils")

return function(c, o)
	return vim.tbl_extend("force", require("themer.highlights.default.lsp")(c, o), {
		-- Xcode issue markers.
		DiagnosticError = { fg = c.bright_red },
		DiagnosticSignError = { fg = c.bright_red },
		DiagnosticFloatingError = { fg = c.bright_red },
		DiagnosticVirtualTextError = { fg = c.bright_red, bg = o.transparent and c.none or u.blend(c.bright_red, c.bg, 0.1) },
		DiagnosticUnderlineError = { sp = c.bright_red, undercurl = true },
		DiagnosticWarn = { fg = c.bright_yellow },
		DiagnosticSignWarn = { fg = c.bright_yellow },
		DiagnosticFloatingWarn = { fg = c.bright_yellow },
		DiagnosticVirtualTextWarn = { fg = c.bright_yellow, bg = o.transparent and c.none or u.blend(c.bright_yellow, c.bg, 0.1) },
		DiagnosticUnderlineWarn = { sp = c.bright_yellow, undercurl = true },
		LspReferenceText = { bg = u.blend(c.surface, c.bg, 0.6) },
		LspReferenceRead = { bg = u.blend(c.surface, c.bg, 0.6) },
		LspReferenceWrite = { bg = u.blend(c.surface, c.bg, 0.6), underline = true },
	})
end
