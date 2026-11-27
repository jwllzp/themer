return function(c, _)
	local levels = { Error = c.red, Warn = c.yellow, Info = c.cyan, Hint = c.blue, Ok = c.green }
	local groups = {
		LspReferenceText = { bg = c.surface },
		LspReferenceRead = { link = "LspReferenceText" },
		LspReferenceWrite = { link = "LspReferenceText" },
		LspInlayHint = { fg = c.comment },
		LspCodeLens = { fg = c.comment },
		LspSignatureActiveParameter = { link = "Visual" },
		DiagnosticDeprecated = { strikethrough = true },
		DiagnosticUnnecessary = { fg = c.comment },
	}
	for level, color in pairs(levels) do
		groups["Diagnostic" .. level] = { fg = color }
		groups["DiagnosticUnderline" .. level] = { sp = color, underline = true }
	end
	return groups
end
