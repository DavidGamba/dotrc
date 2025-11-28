local add = MiniDeps.add

add({
	source = "iofq/dart.nvim",
	depends = {
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
})

require("dart").setup({
	mappings = {
		mark = "<leader>bm", -- Mark current buffer
		jump = "<leader>bs", -- Jump to buffer marked by next character i.e `;a`
		pick = "<leader>bp", -- Open Dart.pick
		next = "<S-l>", -- Cycle right through the tabline
		prev = "<S-h>", -- Cycle left through the tabline
		unmark_all = "<leader>bu", -- Close all marked and recent buffers
	},
})
