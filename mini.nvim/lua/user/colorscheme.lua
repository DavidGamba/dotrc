local add = MiniDeps.add

add({
	source = "folke/tokyonight.nvim",
})

vim.cmd.colorscheme("tokyonight")
