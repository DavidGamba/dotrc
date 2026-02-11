local add = MiniDeps.add

add({ source = "echasnovski/mini.splitjoin", checkout = "stable" })

require("mini.splitjoin").setup({
	mappings = {
		toggle = "<leader>lS",
	},
})

-- Adds <leader>lS keymap
