-- Reset your installation with:
--   rm $HOME/.local/share/nvim/* -rf
-- Update with
--   :lua vim.pack.update()
-- TODO: Update blink tag version when updating
-- ./lua/user/blink.lua
-- TODO: Update tag version when updating
-- ./lua/user/telescope.lua

vim.g.mapleader = " "

------
-- now
------
require("user.record-key") -- show key presses
require("user.options") -- vim options
require("user.keymaps") -- key maps
require("user.colorscheme")
require("user.lualine") -- status line
require("user.treesitter") -- treesitter
require("user.barbecue") -- navic context
require("user.treesitter-context") -- fn context

-- Utilities
require("user.persistence") -- session management

--------
-- later
--------
require("user.oil") -- file manager

-- UI
require("user.which-key") -- key setup with descriptions
require("user.smear-cursor") -- cursor motion shadow/animation

-- Utilities for plugins
require("user.snacks") -- utilities

-- Git
require("user.gitsigns")
require("user.mini-git")

-- LSP
require("user.mason") -- lsp, dap and linter package manager
require("user.lspconfig") -- lsp (requires mason)
require("user.conform") -- formatter, disable with :FormatToggle
require("user.nvim-lint") -- linter
require("user.copilot") -- copilot
require("user.sidekick") -- AI agent UI (completions)

-- Coding
require("user.mini-ai") -- extra text objects
-- require("user.mini-pairs") -- auto pairs -- I fight this more than what I get from it
require("user.mini-surround") -- surround
require("user.mini-splitjoin") -- split join lines
require("user.ts-comments") -- comments for extra languages
-- TODO: Update tag version when updating
-- ./lua/user/blink.lua
require("user.blink") -- completions
require("user.yanky") -- yank ring
require("user.decipher") -- encode/decode
require("user.dap") -- Debugging (requires mason)
require("user.neotest") -- Testing <leader>tt :Coverage

-- Editor
require("user.grug-far") -- search and replace
-- TODO: Update tag version when updating
-- ./lua/user/telescope.lua
require("user.telescope") -- search
require("user.scissors") -- snippets manager (depends on telescope)
require("user.linediff") -- diff blocks :Linediff
require("user.dart") -- buffer pining on tabline ;; ;a ;p

-- Terminal
-- :CommandExecute command ${selection:sh}
require("user.command") -- run a command in a terminal

-- Filetypes
require("user.filetype")

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
