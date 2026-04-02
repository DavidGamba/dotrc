vim.pack.add({
	-- deps
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/kkharji/sqlite.lua",
	"https://github.com/nvim-telescope/telescope-fzy-native.nvim",
	"https://github.com/nvim-telescope/telescope-smart-history.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
})
vim.pack.add({
	{
		src = "https://github.com/nvim-telescope/telescope.nvim",
		version = "v0.2.1",
	},
})

-- TODO: sqllite.lua not working

require("telescope").setup({
	extensions = {
		wrap_results = true,

		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},

		-- ["ui-select"] = {
		--   require("telescope.themes").get_dropdown {},
		-- },
	},
	-- defaults = {
	-- 	history = {
	-- 		path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
	-- 		limit = 100,
	-- 	},
	-- },
})

require("telescope").load_extension("fzy_native")
-- require("telescope").load_extension("smart_history")
require("telescope").load_extension("ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sv", builtin.git_files, { desc = "[S]earch [V]CS files" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>st", builtin.lsp_dynamic_workspace_symbols, { desc = "[S]earch [T]ree" })
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer]" })
vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })

local map = vim.keymap.set

-- Not needed anymore
-- map("n", "<leader>td", function()
-- 	require("telescope.builtin").lsp_definitions({ reuse_win = true })
-- end, { desc = "Goto Definition" })

map("n", "<leader>tr", "<cmd>Telescope lsp_references<cr>", { desc = "References", nowait = true })

map("n", "<leader>tI", function()
	require("telescope.builtin").lsp_implementations({ reuse_win = true })
end, { desc = "Goto Implementation" })

map("n", "<leader>ty", function()
	require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
end, { desc = "Goto T[y]pe Definition" })

map("n", "<leader>ts", function()
	require("telescope.builtin").lsp_document_symbols({ reuse_win = true })
end, { desc = "LSP Document Symbols" })

map("n", "<leader>tS", function()
	require("telescope.builtin").lsp_dynamic_workspace_symbols({ reuse_win = true })
end, { desc = "LSP Dynamic Workspace Symbols" })

map("n", "<leader>ti", function()
	require("telescope.builtin").lsp_incoming_calls({ reuse_win = true })
end, { desc = "LSP Incoming Calls" })

map("n", "<leader>to", function()
	require("telescope.builtin").lsp_outgoing_calls({ reuse_win = true })
end, { desc = "LSP Outgoing Calls" })
