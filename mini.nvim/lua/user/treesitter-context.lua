local add = MiniDeps.add

add({
	source = "nvim-treesitter/nvim-treesitter-context",
})

require("treesitter-context").setup({})
