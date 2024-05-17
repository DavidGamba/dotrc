-- Set core options for the editor
require 'user.core'

if vim.g.vscode then
    -- VSCode extension
else
	require 'user.plugins'
	require 'user.images'

	require 'user.statuscol'

	require 'user.lualine'

	require 'user.colorscheme'

	require 'user.keymap'

	-- Folds
	require 'user.ufo'

	-- Completion plugin
	require 'user.cmp'

	require 'user.lsp'

	require 'user.copilot'
	require 'user.treesitter'
	-- require 'user.ale'

	-- Linter
	require 'user.nvim-lint'

	require 'user.select_ease'
	require 'user.minialign'
	require 'user.debugger'
	require 'user.toggleterm'
	require 'user.comment'
	require 'user.filetype'
	require 'user.devicons'
	require 'user.jabs'
	-- require 'user.projections'

	-- File manager
	require 'user.oil'

	-- Tools
	require 'user.gitsigns'

	require 'user.treesj'
	-- require 'user.aerial'
	-- require 'user.nvim-window-mode'
	-- require 'user.winbar'
	-- require 'user.autoclose'
	require 'user.overrides'
end
