vim.pack.add({
	"https://github.com/ibhagwan/fzf-lua",
})

require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>fr", function() FzfLua.resume() end, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>ff", function() FzfLua.global() end, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fv", function() FzfLua.vcs_files() end, { desc = "[F]ind [V]CS files" })
vim.keymap.set("n", "<leader>fh", function() FzfLua.helptags() end, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fm", function() FzfLua.manpages() end, { desc = "[F]ind [M]anpages" })
vim.keymap.set("n", "<leader>fw", function() FzfLua.grep_cword() end, { desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<leader>fg", function() FzfLua.live_grep() end, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fl", function() FzfLua.lsp_references() end, { desc = "[F]ind by [L]sp references" })
vim.keymap.set("n", "<leader>fG", function() FzfLua.global() end, { desc = "[F]ind [G]lobal" })
vim.keymap.set("n", "<leader>fd", function() FzfLua.diagnostics_document() end, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fq", function() FzfLua.quickfix() end, { desc = "[F]ind [Q]uickfix" })
vim.keymap.set("n", "<leader>ft", function() FzfLua.treesitter() end, { desc = "[F]ind [T]ree" })
vim.keymap.set("n", "<leader>fs", function() FzfLua.lsp_document_symbols() end, { desc = "[F]ind [S]ymbols" })
vim.keymap.set("n", "<leader>fS", function() FzfLua.lsp_dynamic_workspace_symbols() end, { desc = "[F]ind Workspace [S]ymbols" })
vim.keymap.set("n", "<leader>fb", function() FzfLua.builtin() end, { desc = "[F]ind [B]uiltin" })
vim.keymap.set("n", "<leader>f/", function() FzfLua.live_grep() end, { desc = "[/] Fuzzily search in current buffer]" })
