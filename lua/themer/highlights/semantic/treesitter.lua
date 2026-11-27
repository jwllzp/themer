return function(c, _)
	local system = { fg = c.bright_magenta }
	return {
		-- Locals/parameters stay plain; project-level members are "identifier" green.
		["@variable"] = { fg = c.fg },
		["@variable.builtin"] = { fg = c.magenta, bold = true }, -- self / this are keywords in Xcode
		["@variable.parameter"] = { fg = c.fg },
		["@variable.member"] = { fg = c.green },
		["@property"] = { fg = c.green },

		["@constant"] = { fg = c.green },
		["@constant.builtin"] = system,
		["@constant.macro"] = { fg = c.orange },

		["@module"] = { fg = c.bright_cyan },
		["@module.builtin"] = system,
		["@label"] = { link = "Label" },

		["@string"] = { link = "String" },
		["@string.documentation"] = { link = "Comment" },
		["@string.regexp"] = { fg = c.red },
		["@string.escape"] = { fg = c.fg_dim },
		["@string.special"] = { fg = c.fg_dim },
		["@string.special.path"] = { fg = c.red },
		["@string.special.symbol"] = { fg = c.green },
		["@string.special.url"] = { fg = c.blue, underline = true },

		["@character"] = { link = "Character" },
		["@character.special"] = { fg = c.fg_dim },
		["@boolean"] = { link = "Boolean" },
		["@number"] = { link = "Number" },
		["@number.float"] = { link = "Number" },

		["@type"] = { fg = c.bright_cyan },
		["@type.builtin"] = system,
		["@type.definition"] = { fg = c.bright_blue },
		["@attribute"] = { fg = c.brown },
		["@attribute.builtin"] = { fg = c.brown },

		-- Treesitter's @function / @function.method are definitions, *.call are uses.
		["@function"] = { fg = c.cyan },
		["@function.call"] = { fg = c.green },
		["@function.method"] = { fg = c.cyan },
		["@function.method.call"] = { fg = c.green },
		["@function.builtin"] = system,
		["@function.macro"] = { fg = c.orange },
		["@constructor"] = { fg = c.bright_cyan },
		["@operator"] = { link = "Operator" },

		["@keyword"] = { link = "Keyword" },
		["@keyword.modifier"] = { link = "Keyword" },
		["@keyword.type"] = { link = "Keyword" },
		["@keyword.coroutine"] = { link = "Keyword" },
		["@keyword.function"] = { link = "Keyword" },
		["@keyword.operator"] = { link = "Keyword" },
		["@keyword.import"] = { link = "Keyword" },
		["@keyword.repeat"] = { link = "Keyword" },
		["@keyword.return"] = { link = "Keyword" },
		["@keyword.debug"] = { link = "Keyword" },
		["@keyword.exception"] = { link = "Keyword" },
		["@keyword.conditional"] = { link = "Keyword" },
		["@keyword.conditional.ternary"] = { link = "Operator" },
		["@keyword.directive"] = { link = "PreProc" },
		["@keyword.directive.define"] = { link = "PreProc" },
		["@keyword.export"] = { link = "Keyword" },

		["@punctuation.delimiter"] = { fg = c.fg },
		["@punctuation.bracket"] = { fg = c.fg },
		["@punctuation.special"] = { fg = c.fg_dim },

		["@comment"] = { link = "Comment" },
		["@comment.documentation"] = { link = "Comment" },
		["@comment.error"] = { fg = c.bright_red, bold = true },
		["@comment.warning"] = { fg = c.bright_yellow, bold = true },
		["@comment.hint"] = { fg = c.fg_dim, bold = true },
		["@comment.todo"] = { fg = c.fg_dim, bold = true }, -- xcode.syntax.mark
		["@comment.note"] = { fg = c.fg_dim, bold = true },

		-- Markup follows Xcode's markup renderer: white text, weights carry hierarchy.
		["@markup"] = { fg = c.fg },
		["@markup.strong"] = { fg = c.fg_bright, bold = true },
		["@markup.italic"] = { fg = c.fg_bright, italic = true },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },
		["@markup.heading"] = { fg = c.fg_bright, bold = true },
		["@markup.heading.1"] = { fg = c.fg_bright, bold = true },
		["@markup.heading.2"] = { fg = c.fg_bright, bold = true },
		["@markup.heading.3"] = { fg = c.fg, bold = true },
		["@markup.heading.4"] = { fg = c.fg_dim, bold = true },
		["@markup.heading.5"] = { fg = c.fg_dim, bold = true },
		["@markup.heading.6"] = { fg = c.fg_dim, bold = true },
		["@markup.quote"] = { fg = c.fg_dim, italic = true },
		["@markup.math"] = { fg = c.yellow },
		["@markup.link"] = { fg = c.blue },
		["@markup.link.label"] = { fg = c.blue },
		["@markup.link.url"] = { fg = c.blue, underline = true },
		["@markup.raw"] = { fg = c.fg_dim },
		["@markup.list"] = { fg = c.magenta },
		["@markup.list.checked"] = { fg = c.bright_green },
		["@markup.list.unchecked"] = { fg = c.fg_dim },

		["@diff.plus"] = { link = "Added" },
		["@diff.minus"] = { link = "Removed" },
		["@diff.delta"] = { link = "Changed" },

		["@tag"] = { fg = c.magenta },
		["@tag.builtin"] = system,
		["@tag.attribute"] = { fg = c.brown },
		["@tag.delimiter"] = { fg = c.fg },
	}
end
