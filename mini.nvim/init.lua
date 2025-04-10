-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/echasnovski/mini.nvim",
		mini_path,
	}
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.nvim | helptags ALL")
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Update with :DepsUpdate

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })
local now, later = MiniDeps.now, MiniDeps.later

vim.g.mapleader = " "

now(function()
	require("user.options") -- vim options
	require("user.keymaps") -- key maps
	require("user.colorscheme")
	require("user.lualine") -- status line
	require("user.treesitter") -- treesitter

	-- Utilities
	require("user.persistence") -- session management
end)

later(function()
	require("user.oil") -- file manager

	-- UI
	require("user.which-key") -- key setup with descriptions
	-- require("user.smear-cursor") -- cursor motion shadow/animation
	require("user.barbecue") -- navic context
	require("user.treesitter-context") -- fn context

	-- Utilities for plugins
	require("user.snacks") -- utilities

	-- Git
	require("user.gitsigns")

	-- LSP
	require("user.mason") -- lsp, dap and linter package manager
	require("user.conform") -- formatter
	require("user.nvim-lint") -- linter
	require("user.lspconfig") -- lsp
	require("user.copilot") -- copilot

	-- Coding
	require("user.mini-ai") -- extra text objects
	require("user.mini-pairs") -- auto pairs
	require("user.mini-surround") -- surround
	require("user.mini-splitjoin") -- split join lines
	require("user.ts-comments") -- comments for extra languages
	-- TODO: Update blink tag version when updating
	-- ./lua/user/blink.lua
	require("user.blink") -- completions
	require("user.yanky") -- yank ring
	require("user.decipher") -- encode/decode
	require("user.scissors") -- snippets manager
	require("user.dap") -- Debugging
	require("user.neotest") -- Testing
	require("user.coverage") -- Testing coverage

	-- Editor
	require("user.grug-far") -- search and replace
	require("user.telescope") -- search
	require("user.linediff") -- diff blocks

	-- TODO:
	--
	-- vim-abolish:
	-- Provides CoeRce MixedCase (crm), CoeRce camelCase (crc), CoeRce snake_case (crs), and CoeRce UPPER_CASE (cru)
	--
	-- folding:
	-- "kevinhwang91/nvim-ufo",
	--
	-- images:
	-- "3rd/image.nvim",
end)
