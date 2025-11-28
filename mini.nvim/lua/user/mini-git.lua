local add = MiniDeps.add

add({
	source = "nvim-mini/mini.nvim",
})

require("mini.git").setup({
	mappings = {
		add = "sa", -- Add surrounding in Normal and Visual modes
		delete = "sd", -- Delete surrounding
		find = "sf", -- Find surrounding (to the right)
		find_left = "sF", -- Find surrounding (to the left)
		highlight = "sh", -- Highlight surrounding
		replace = "sr", -- Replace surrounding
		update_n_lines = "sn", -- Update `n_lines`

		suffix_last = "l", -- Suffix to search with "prev" method
		suffix_next = "n", -- Suffix to search with "next" method
	},
})

vim.keymap.set({ "n", "v" }, "<leader>gr", function()
	MiniGit.show_range_history()
end, { desc = "show range history", remap = true })
vim.keymap.set({ "n", "v" }, "<leader>gs", function()
	MiniGit.show_diff_source()
end, { desc = "open diff source file", remap = true })
vim.keymap.set({ "n", "v" }, "<leader>gi", function()
	MiniGit.show_at_cursor()
end, { desc = "show info", remap = true })
