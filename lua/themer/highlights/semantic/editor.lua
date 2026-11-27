local u = require("themer.utils")

-- Xcode-like UI on top of the default editor groups.
return function(c, o)
	local bg = o.transparent and c.none or c.bg
	return vim.tbl_extend("force", require("themer.highlights.default.editor")(c, o), {
		Cursor = { fg = c.bg, bg = c.blue },
		CursorLine = { bg = c.bg_alt },
		CursorLineNr = { fg = c.fg },
		LineNr = { fg = c.comment },
		Visual = { bg = c.surface },
		NonText = { fg = u.blend(c.surface, c.bg, 0.7) },
		Whitespace = { fg = u.blend(c.surface, c.bg, 0.7) },
		FloatBorder = { fg = u.blend(c.fg_dim, c.bg, 0.4), bg = o.transparent and c.none or c.bg_dark },
		MatchParen = { fg = c.fg_bright, bg = c.surface, bold = true },
		Directory = { fg = c.bright_cyan },
		Title = { fg = c.fg_bright, bold = true },
		WinSeparator = { fg = u.blend(c.fg_dim, c.bg, 0.25), bg = bg },
		Search = { fg = c.bg, bg = c.bright_yellow },
		IncSearch = { fg = c.bg, bg = c.yellow },
		CurSearch = { link = "IncSearch" },
	})
end
