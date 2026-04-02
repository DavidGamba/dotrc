vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

require("mini.git").setup()

vim.keymap.set({ "n", "v" }, "<leader>gr", function()
	MiniGit.show_range_history()
end, { desc = "show range history", remap = true })
vim.keymap.set({ "n", "v" }, "<leader>gs", function()
	MiniGit.show_diff_source()
end, { desc = "open diff source file", remap = true })
vim.keymap.set({ "n", "v" }, "<leader>gi", function()
	MiniGit.show_at_cursor()
end, { desc = "show info", remap = true })
