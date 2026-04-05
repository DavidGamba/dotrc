vim.pack.add({
	"https://github.com/zbirenbaum/copilot.lua",
})

require("copilot").setup({
	-- Use copilot through blink and sidekick
	nes = { enabled = false },
	suggestion = { enabled = false },
	panel = { enabled = false },
})
