local add = MiniDeps.add

add({
	source = "folke/snacks.nvim",
})

require("snacks").setup({
	gitbrowse = { enabled = true },
	rename = { enabled = true },
	words = { enabled = true },
})
