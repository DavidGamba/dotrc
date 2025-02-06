local add = MiniDeps.add

add({
	source = "chrisgrieser/nvim-scissors",
	depends = {
		"nvim-telescope/telescope.nvim",
	},
})

require("scissors").setup({
	snippetDir = vim.fn.stdpath("config") .. "/snippets",
})

vim.keymap.set("n", "<leader>se", function()
	require("scissors").editSnippet()
end, { desc = "Snippet: Edit" })

-- when used in visual mode, prefills the selection as snippet body
vim.keymap.set({ "n", "x" }, "<leader>sa", function()
	require("scissors").addNewSnippet()
end, { desc = "Snippet: Add" })
