if vim.g.loaded_themer then
	return
end
vim.g.loaded_themer = true

vim.api.nvim_create_user_command("ThemerCompile", function()
	require("themer").compile()
	if vim.g.colors_name == "themer" then
		require("themer").load()
	end
	vim.notify("themer: compiled")
end, { desc = "Rebuild the themer highlight cache" })

vim.api.nvim_create_user_command("ThemerClearCache", function()
	vim.fn.delete(require("themer.utils").cache_dir, "rf")
	vim.notify("themer: cache cleared")
end, { desc = "Delete the themer highlight cache" })
