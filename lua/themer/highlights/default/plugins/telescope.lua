return function(c, o)
	local float = o.transparent and c.none or c.bg_dark
	return {
		TelescopeNormal = { fg = c.fg, bg = float },
		TelescopeBorder = { fg = c.blue, bg = float },
		TelescopeTitle = { fg = c.bg_dark, bg = c.blue, bold = true },
		TelescopePromptNormal = { fg = c.fg, bg = float },
		TelescopePromptBorder = { fg = c.blue, bg = float },
		TelescopePromptTitle = { fg = c.bg_dark, bg = c.red, bold = true },
		TelescopePromptPrefix = { fg = c.brown },
		TelescopePromptCounter = { fg = c.comment },
		TelescopeResultsTitle = { fg = c.bg_dark, bg = c.bright_blue, bold = true },
		TelescopePreviewTitle = { fg = c.bg_dark, bg = c.green, bold = true },
		TelescopeSelection = { fg = c.fg, bg = c.bg_alt, bold = true },
		TelescopeSelectionCaret = { fg = c.brown, bg = c.bg_alt },
		TelescopeMultiSelection = { fg = c.magenta },
		TelescopeMatching = { fg = c.blue, bold = true },
	}
end
