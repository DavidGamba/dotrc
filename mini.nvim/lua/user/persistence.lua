local add = MiniDeps.add

add({
	source = "folke/persistence.nvim",
})

require("persistence").setup({})

-- load the session for the current directory
vim.keymap.set("n", "<leader>qs", function()
	require("persistence").load()
end, { desc = "load session for the current directory" })

-- select a session to load
vim.keymap.set("n", "<leader>qS", function()
	require("persistence").select()
end, { desc = "select session to load" })

-- load the last session
vim.keymap.set("n", "<leader>ql", function()
	require("persistence").load({ last = true })
end, { desc = "load last session" })

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function()
	require("persistence").stop()
end, { desc = "stop persistence" })
