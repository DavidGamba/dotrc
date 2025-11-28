local add = MiniDeps.add

add({
	source = "echasnovski/mini.surround",
})

require("mini.surround").setup({
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

vim.keymap.set("n", "sq", "saiwq", { desc = "quote word", remap = true })
vim.keymap.set("v", "sq", "saq", { desc = "quote selection", remap = true })
vim.keymap.set("n", "s'", "saiw'", { desc = "quote word", remap = true })
vim.keymap.set("v", "s'", "sa'", { desc = "quote selection", remap = true })
vim.keymap.set("n", "s`", "saiw`", { desc = "quote word", remap = true })
vim.keymap.set("v", "s`", "sa`", { desc = "quote selection", remap = true })
vim.keymap.set("n", "s}", "saiw}", { desc = "quote word", remap = true })
vim.keymap.set("v", "s}", "sa}", { desc = "quote selection", remap = true })
vim.keymap.set("n", "s)", "saiw)", { desc = "quote word", remap = true })
vim.keymap.set("v", "s)", "sa)", { desc = "quote selection", remap = true })
vim.keymap.set("n", "s(", "saiw(", { desc = "quote word", remap = true })
vim.keymap.set("v", "s(", "sa(", { desc = "quote selection", remap = true })
vim.keymap.set("n", "s]", "saiw]", { desc = "quote word", remap = true })
vim.keymap.set("v", "s]", "sa]", { desc = "quote selection", remap = true })
vim.keymap.set("n", "s>", "saiw>", { desc = "quote word", remap = true })
vim.keymap.set("v", "s>", "sa>", { desc = "quote selection", remap = true })
vim.keymap.set("n", "s<", "saiw<", { desc = "quote word", remap = true })
vim.keymap.set("v", "s<", "sa<", { desc = "quote selection", remap = true })
