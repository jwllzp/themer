return function(c, _)
	return {
		Comment = { fg = c.comment },
		Constant = { fg = c.fg },
		String = { fg = c.green },
		Character = { link = "Constant" },
		Identifier = { fg = c.blue },
		Function = { fg = c.cyan },
		Statement = { fg = c.fg, bold = true },
		Operator = { fg = c.fg },
		PreProc = { fg = c.fg },
		Type = { fg = c.fg },
		Special = { fg = c.cyan },
		Delimiter = { fg = c.fg },
		Underlined = { underline = true },
		Error = { fg = c.fg_bright, bg = c.red },
		Todo = { fg = c.fg, bold = true },
	}
end
