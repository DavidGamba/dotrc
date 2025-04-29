local add = MiniDeps.add

add({
	source = "wsdjeg/record-key.nvim",
})

require("record-key").setup({
	timeout = 10000,
})

vim.keymap.set("n", "<leader>rk", "<cmd>RecordKeyToggle<cr>", { silent = true, desc = "encode base64" })
