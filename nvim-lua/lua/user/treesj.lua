local status_ok, treesj = pcall(require, "treesj")
if not status_ok then
	return
end
treesj.setup({
	use_default_keymaps = false,
	max_join_length = 200,
})

vim.keymap.set('n', '<leader>cs', ':TSJToggle<CR>' , { desc = '[C]ode [S]plit/join Toggle' })
