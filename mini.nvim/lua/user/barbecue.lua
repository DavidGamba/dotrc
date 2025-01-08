local add = MiniDeps.add

add({
	source = "utilyre/barbecue.nvim",
	depends = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
})

require("barbecue").setup({})
