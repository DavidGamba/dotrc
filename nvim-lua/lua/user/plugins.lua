-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	print "ERROR: Failed to load packer!"
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Install your plugins here
packer.startup(function(use)
	use 'wbthomason/packer.nvim' -- manage self

	--------------------------------------
	-- Dependencies for other plugins
	--------------------------------------
	use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
	use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

	--------------------------------------
	-- colorscheme
	--------------------------------------
	use 'NLKNguyen/papercolor-theme'
	vim.g.PaperColor_Theme_Options = {
		theme = {
			default = {
				allow_bold = 1,
				allow_italic = 1
			},
		},
	}

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	use 'luukvbaal/statuscol.nvim'

	-- use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines

	use 'kyazdani42/nvim-web-devicons'

	use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}
	--------------------------------------

	--------------------------------------
	-- core
	--------------------------------------
	use "antoinemadec/FixCursorHold.nvim" -- Fix CursorHold event slowness

	-- use 'bfredl/nvim-miniyank'
	-- vim.g.miniyank_filename = os.getenv("HOME") .. "/.miniyank.mpack"

	-- Enable submodes, used for window submode
	use 'Iron-E/nvim-libmodal'
	use 'DavidGamba/nvim-window-mode'
	-- use {'Iron-E/nvim-bufmode', wants='nvim-libmodal'}

	-- Conflicts with toggleterm
	-- use 'christoomey/vim-tmux-navigator'

	-- use 'neomake/neomake'
	-- vim.g.neomake_shellcheck_args = { '-fgcc' }

	-- use 'dense-analysis/ale'
	use 'mfussenegger/nvim-lint'

	use "akinsho/toggleterm.nvim"
	--------------------------------------

	--------------------------------------
	-- telescope
	--------------------------------------
	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
		},
	}
	use {
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'make',
		cond = vim.fn.executable 'make' == 1
	}
	--------------------------------------

	--------------------------------------
	-- lsp
	--------------------------------------
	use 'neovim/nvim-lspconfig'
	use 'ray-x/lsp_signature.nvim'

	-- 	use { 'ray-x/go.nvim' }
	use { 'mfussenegger/nvim-dap' }
	use { 'rcarriga/nvim-dap-ui' }
	use { 'leoluz/nvim-dap-go' } -- configuration for dap to work with delve


	-- GPS
	use {
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig"
	}

	use 'github/copilot.vim'
	--------------------------------------

	--------------------------------------
	-- Completion
	--------------------------------------
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			"saadparwaiz1/cmp_luasnip", -- snippet completions
		},
	}
	--------------------------------------

	--------------------------------------
	-- snippets
	--------------------------------------
	use {
		'SirVer/ultisnips',
		requires = {
			'honza/vim-snippets',
			'quangnguyen30192/cmp-nvim-ultisnips',
		}
	}
	vim.g.UltiSnipsExpandTrigger = "<tab>"
	if not vim.g.UltiSnipsSnippetDirectories then
		vim.g.UltiSnipsSnippetDirectories = { os.getenv("HOME") .. "/dotrc/vim-snippets" }
	else
		table.insert(vim.g.UltiSnipsSnippetDirectories, os.getenv("HOME") .. "/dotrc/vim-snippets")
	end
	vim.g.UltiSnipsJumpForwardTrigger = "<c-l>"
	vim.g.UltiSnipsJumpBackwardTrigger = "<c-h>"
	--------------------------------------

	--------------------------------------
	-- Treesitter
	--------------------------------------
	use {
		"nvim-treesitter/nvim-treesitter",
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end
	}
	use 'nvim-treesitter/nvim-treesitter-context'
	--------------------------------------

	--------------------------------------
	-- Editing
	--------------------------------------
	-- use 'LunarWatcher/auto-pairs'
	use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
	-- use 'tpope/vim-commentary'
	use 'numToStr/Comment.nvim'
	use 'tpope/vim-surround'

	-- Provides CoeRce MixedCase (crm), CoeRce camelCase (crc), CoeRce snake_case (crs), and CoeRce UPPER_CASE (cru)
	use 'tpope/vim-abolish'

	-- use 'junegunn/vim-easy-align'
	-- use 'vim-scripts/vis' -- Visual mode B

	-- " <leader>e to search/replace word under cursor
	-- use 'wincent/scalpel'
	
	use 'ziontee113/SelectEase'
	--------------------------------------

	--------------------------------------
	-- Tools
	--------------------------------------
	-- <leader>sf
	use 'obreitwi/vim-sort-folds'
	-- :Linediff
	use 'AndrewRadev/linediff.vim'

	use 'easymotion/vim-easymotion'
	vim.g.EasyMotion_smartcase = 1
	vim.g.EasyMotion_use_smartsign_us = 1

	-- :Explore
	-- use 'justinmk/vim-dirvish'
	-- use 'tpope/vim-vinegar'
	-- :NERDTreeToggle
	-- use 'scrooloose/nerdtree'
	use 'stevearc/oil.nvim'

	-- use 'airblade/vim-gitgutter'
	use {
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	}
	-- use {
	-- 	'lewis6991/gitsigns.nvim',
	-- 	requires = {
	-- 		'nvim-lua/plenary.nvim'
	-- 	},
	-- 	config = function()
	-- 		require('gitsigns').setup()
	-- 	end
	-- }

	-- use 'wincent/corpus'

	-- Git support
	use 'tpope/vim-fugitive'

	-- :OpenInGHRepo
	-- :OpenInGHFile
	use 'almo7aya/openingh.nvim'

	-- Extra command pairs to do many things
	-- A mnemonic for the "a" commands is "args" and for the "q" commands is "quickfix"
	-- The mnemonic for y is that if you tilt it a bit it looks like a switch.
	use 'tpope/vim-unimpaired'

	-- :SemanticHighlightToggle
	use 'jaxbot/semantic-highlight.vim'

	-- buffer switcher window
	use 'matbme/JABS.nvim'

	-- Flow state reading in neovim:
	-- :FSRead
	-- :FSClear
	-- :FSToggle
	use 'nullchilly/fsread.nvim'

	-- Autoclose
	-- use 'm4xshen/autoclose.nvim'

	use 'gnikdroy/projections.nvim'

	-- use 'stevearc/aerial.nvim'

	use 'Wansmer/treesj'


	--------------------------------------

	--------------------------------------
	-- Language support
	--------------------------------------
	use { 'hashivim/vim-terraform' }
	use { 'suoto/vim-antlr', ft = { 'antlr4' } }
	--------------------------------------

	use { 'lewis6991/spellsitter.nvim' }

	--------------------------------------
	-- Images
	--------------------------------------
	use {'edluffy/hologram.nvim'}

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
	return
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
