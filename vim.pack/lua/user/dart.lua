vim.pack.add({
	-- deps
	"https://github.com/nvim-tree/nvim-web-devicons", -- optional dependency
	-- src
	"https://github.com/iofq/dart.nvim",
})

require("dart").setup({
	buflist = { "z", "v", "c", "e", "r" },
	mappings = {
		mark = ";;", -- Mark current buffer
		jump = ";", -- Jump to buffer marked by next character i.e `;a`
		pick = ";p", -- Open Dart.pick
		next = "<S-l>", -- Cycle right through the tabline
		prev = "<S-h>", -- Cycle left through the tabline
		unmark_all = ";u", -- Close all marked and recent buffers
	},
})
