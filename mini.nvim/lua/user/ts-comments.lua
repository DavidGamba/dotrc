local add = MiniDeps.add

add({
	source = "folke/ts-comments.nvim",
})

require("ts-comments").setup({})
