local add = MiniDeps.add

add({
	source = "andythigpen/nvim-coverage",
	depends = {
		"nvim-lua/plenary.nvim",
	},
})

require("coverage").setup({})
