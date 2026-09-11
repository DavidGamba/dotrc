vim.pack.add({
	"https://github.com/copilotlsp-nvim/copilot-lsp",
})
vim.pack.add({
	"https://github.com/zbirenbaum/copilot.lua",
})

require("copilot").setup({
	-- Use copilot through blink and sidekick
	-- nes = {
	-- 	enabled = true,
	-- 	keymap = {
	-- 		accept_and_goto = "<c-.>",
	-- 		accept = false,
	-- 		dismiss = "<Esc>",
	-- 	},
	-- },
	nes = { enabled = false },
	suggestion = { enabled = false },
	panel = { enabled = false },
})

-- copilot_ls
vim.g.copilot_nes_debounce = 50

vim.keymap.set({ "n", "i" }, "<Tab>", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local state = vim.b[bufnr].nes_state
	if state then
		-- Try to jump to the start of the suggestion edit.
		-- If already at the start, then apply the pending suggestion and jump to the end of the edit.
		local _ = require("copilot-lsp.nes").walk_cursor_start_edit() or (require("copilot-lsp.nes").apply_pending_nes() and require("copilot-lsp.nes").walk_cursor_end_edit())
		return nil
	else
		-- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
		return "<c-i>"
	end
end, { desc = "Accept Copilot NES suggestion", expr = true })

-- Clear copilot suggestion with Esc if visible, otherwise preserve default Esc behavior
vim.keymap.set("n", "<esc>", function()
	if not require("copilot-lsp.nes").clear() then
		return "<esc>"
	end
end, { desc = "Clear Copilot suggestion or fallback" })
