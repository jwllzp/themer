-- Neovim's defaults already link most captures to the syntax groups above.
return function(c, _)
	return {
		["@variable"] = { fg = c.fg },
		["@variable.builtin"] = { link = "Special" },
		["@function.builtin"] = { link = "Special" },
		["@type.builtin"] = { link = "Special" },
		["@constant.builtin"] = { link = "Special" },
		["@property"] = { link = "Identifier" },
		["@punctuation.special"] = { link = "Special" },
		["@markup.heading"] = { link = "Title" },
		["@markup.link.url"] = { fg = c.cyan, underline = true },
		["@markup.raw"] = { fg = c.fg_dim },
	}
end
