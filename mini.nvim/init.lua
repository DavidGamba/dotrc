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

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

vim.g.mapleader = " "

require("user.options") -- vim options
require("user.which-key") -- key setup with descriptions
require("user.oil") -- file manager
require("user.keymaps") -- key maps

-- UI
require("user.colorscheme")
require("user.lualine") -- status line

-- Utilities for plugins
require("user.snacks") -- utilities

-- Git
require("user.gitsigns")

-- LSP
require("user.mason") -- lsp, dap and linter package manager
require("user.conform") -- formatter
require("user.nvim-lint") -- linter
require("user.lspconfig") -- lsp
require("user.treesitter") -- treesitter

-- Coding
require("user.mini-ai") -- extra text objects
require("user.mini-pairs") -- auto pairs
require("user.mini-surround") -- surround
require("user.mini-splitjoin") -- split join lines
require("user.ts-comments") -- comments for extra languages
-- TODO: Update blink tag version when updating
require("user.blink") -- completions

-- Editor
require("user.grug-far") -- search and replace
require("user.telescope") -- search
