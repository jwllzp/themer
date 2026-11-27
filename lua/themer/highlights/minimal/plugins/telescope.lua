return function(c, o)
	local float = o.transparent and c.none or c.bg_darker
	return {
		TelescopeNormal = { fg = c.fg, bg = float },
		TelescopeBorder = { fg = c.surface, bg = float },
		TelescopeTitle = { fg = c.fg, bold = true },
		TelescopePromptPrefix = { fg = c.cyan },
		TelescopeSelection = { bg = c.bg_alt },
		TelescopeSelectionCaret = { fg = c.cyan, bg = c.bg_alt },
		TelescopeMultiSelection = { fg = c.cyan },
		TelescopeMatching = { fg = c.cyan, bold = true },
	}
end
