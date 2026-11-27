local u = require("themer.utils")

return function(c, o)
	local function vt(color)
		return { fg = color, bg = o.transparent and c.none or u.blend(color, c.bg, 0.1) }
	end
	local levels = { Error = c.red, Warn = c.yellow, Info = c.bright_cyan, Hint = c.cyan, Ok = c.green }

	local groups = {
		LspReferenceText = { bg = c.surface },
		LspReferenceRead = { bg = c.surface },
		LspReferenceWrite = { bg = c.surface },
		LspReferenceTarget = { link = "LspReferenceText" },
		LspInlayHint = { fg = c.comment, bg = o.transparent and c.none or u.blend(c.bg_alt, c.bg, 0.64) },
		LspCodeLens = { fg = c.comment },
		LspCodeLensSeparator = { link = "LspCodeLens" },
		LspSignatureActiveParameter = { bg = c.bg_alt, bold = true },
		LspInfoBorder = { link = "FloatBorder" },
		DiagnosticDeprecated = { strikethrough = true },
		DiagnosticUnnecessary = { fg = c.comment },
	}
	for level, color in pairs(levels) do
		groups["Diagnostic" .. level] = { fg = color }
		groups["DiagnosticSign" .. level] = { fg = color }
		groups["DiagnosticFloating" .. level] = { fg = color }
		groups["DiagnosticVirtualText" .. level] = vt(color)
		groups["DiagnosticVirtualLines" .. level] = { fg = color }
		groups["DiagnosticUnderline" .. level] = { sp = color, undercurl = true }
	end
	return groups
end
