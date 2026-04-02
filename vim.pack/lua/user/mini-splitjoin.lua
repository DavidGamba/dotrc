vim.pack.add({
	"https://github.com/echasnovski/mini.splitjoin",
})

require("mini.splitjoin").setup({
	mappings = {
		toggle = "<leader>lS",
	},
})

-- Adds <leader>lS keymap
