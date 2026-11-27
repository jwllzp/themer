-- LSP semantic tokens carry exactly the distinctions Xcode makes:
-- `declaration` (definition site) and `defaultLibrary` (system symbol).
-- Priority: @lsp.type (125) < @lsp.mod (126) < @lsp.typemod (127).
return function(c, _)
	local system = { fg = c.bright_magenta }
	local groups = {
		["@lsp.type.boolean"] = { link = "@boolean" },
		["@lsp.type.builtinType"] = system,
		["@lsp.type.comment"] = { link = "@comment" },
		["@lsp.type.decorator"] = { link = "@attribute" },
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.enumMember"] = { link = "@constant" },
		["@lsp.type.escapeSequence"] = { link = "@string.escape" },
		["@lsp.type.formatSpecifier"] = { link = "@string.escape" },
		["@lsp.type.function"] = { link = "@function.call" },
		["@lsp.type.method"] = { link = "@function.method.call" },
		["@lsp.type.interface"] = { link = "@type" },
		["@lsp.type.class"] = { link = "@type" },
		["@lsp.type.struct"] = { link = "@type" },
		["@lsp.type.type"] = { link = "@type" },
		["@lsp.type.typeParameter"] = { link = "@type" },
		["@lsp.type.keyword"] = { link = "@keyword" },
		["@lsp.type.macro"] = { link = "@constant.macro" },
		["@lsp.type.namespace"] = { link = "@module" },
		["@lsp.type.number"] = { link = "@number" },
		["@lsp.type.operator"] = { link = "@operator" },
		["@lsp.type.parameter"] = { link = "@variable.parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
		["@lsp.type.selfTypeKeyword"] = { link = "@variable.builtin" },
		["@lsp.type.typeAlias"] = { link = "@type" },
		["@lsp.type.unresolvedReference"] = { sp = c.bright_red, undercurl = true },
		["@lsp.type.variable"] = {},

		["@lsp.mod.defaultLibrary"] = system,
		["@lsp.mod.deprecated"] = { strikethrough = true },
		["@lsp.typemod.variable.global"] = { fg = c.green },
		["@lsp.typemod.variable.readonly"] = { fg = c.green },
		["@lsp.typemod.variable.defaultLibrary"] = system,
		["@lsp.typemod.keyword.async"] = { link = "@keyword" },
	}
	for _, kind in ipairs({ "function", "method" }) do
		groups["@lsp.typemod." .. kind .. ".declaration"] = { fg = c.cyan }
		groups["@lsp.typemod." .. kind .. ".definition"] = { fg = c.cyan }
		groups["@lsp.typemod." .. kind .. ".defaultLibrary"] = system
	end
	for _, kind in ipairs({ "class", "struct", "enum", "interface", "type", "typeAlias" }) do
		groups["@lsp.typemod." .. kind .. ".declaration"] = { fg = c.bright_blue }
		groups["@lsp.typemod." .. kind .. ".definition"] = { fg = c.bright_blue }
		groups["@lsp.typemod." .. kind .. ".defaultLibrary"] = system
	end
	return groups
end
