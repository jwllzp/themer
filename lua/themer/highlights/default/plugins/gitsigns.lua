local u = require("themer.utils")

return function(c, _)
	local function bg(color, a)
		return u.blend(color, c.bg, a)
	end
	return {
		GitSignsAdd = { fg = c.green },
		GitSignsChange = { fg = c.yellow },
		GitSignsDelete = { fg = c.red },
		GitSignsTopdelete = { link = "GitSignsDelete" },
		GitSignsChangedelete = { link = "GitSignsChange" },
		GitSignsUntracked = { fg = c.cyan },
		GitSignsAddNr = { link = "GitSignsAdd" },
		GitSignsChangeNr = { link = "GitSignsChange" },
		GitSignsDeleteNr = { link = "GitSignsDelete" },
		GitSignsAddLn = { bg = bg(c.green, 0.12) },
		GitSignsChangeLn = { bg = bg(c.yellow, 0.12) },
		GitSignsDeleteLn = { bg = bg(c.red, 0.12) },
		GitSignsAddPreview = { link = "DiffAdd" },
		GitSignsDeletePreview = { link = "DiffDelete" },
		GitSignsAddInline = { bg = bg(c.green, 0.3) },
		GitSignsChangeInline = { bg = bg(c.yellow, 0.3) },
		GitSignsDeleteInline = { bg = bg(c.red, 0.3) },
		GitSignsAddLnInline = { link = "GitSignsAddInline" },
		GitSignsChangeLnInline = { link = "GitSignsChangeInline" },
		GitSignsDeleteLnInline = { link = "GitSignsDeleteInline" },
		GitSignsDeleteVirtLn = { link = "DiffDelete" },
		GitSignsCurrentLineBlame = { fg = c.comment, italic = true },
		GitSignsStagedAdd = { fg = u.blend(c.green, c.bg, 0.5) },
		GitSignsStagedChange = { fg = u.blend(c.yellow, c.bg, 0.5) },
		GitSignsStagedDelete = { fg = u.blend(c.red, c.bg, 0.5) },
		GitSignsStagedTopdelete = { link = "GitSignsStagedDelete" },
		GitSignsStagedChangedelete = { link = "GitSignsStagedChange" },
	}
end
