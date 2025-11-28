local add = MiniDeps.add

add({
	source = "zbirenbaum/copilot.lua",
	depends = {
		"copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
	},
})

require("copilot").setup({
	nes = {
		enabled = false,
		keymap = {
			accept_and_goto = "<leader>p",
			accept = false,
			dismiss = "<Esc>",
		},
	},
	suggestion = {
		auto_trigger = false,
	},
})

-- panel = {
--   keymap = {
--     jump_prev = "[[",
--     jump_next = "]]",
--     accept = "<CR>",
--     refresh = "gr",
--     open = "<M-CR>"
--   },
-- },
-- suggestion = {
--   keymap = {
--     accept = "<M-l>",
--     accept_word = false,
--     accept_line = false,
--     next = "<M-]>",
--     prev = "<M-[>",
--     dismiss = "<C-]>",
--   },
-- }
