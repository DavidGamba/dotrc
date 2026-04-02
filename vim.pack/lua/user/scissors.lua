vim.pack.add({
	-- deps
	-- "https://github.com/nvim-telescope/telescope.nvim",
	-- src
	"https://github.com/chrisgrieser/nvim-scissors",
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
