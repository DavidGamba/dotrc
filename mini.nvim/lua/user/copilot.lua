local add = MiniDeps.add

add({
	source = "zbirenbaum/copilot.lua",
})

require("copilot").setup({
	suggestion = {
		auto_trigger = true,
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
