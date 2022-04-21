-- Bootstrap
-- https://github.com/wbthomason/packer.nvim
--- install packer if unable to load
if not pcall(require, 'packer') then
  local packer_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
  print 'packer.vim installed ... please restart neovim'
end

-- Plugins
return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	
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
	vim.cmd('colorscheme PaperColor')
	vim.cmd('set background=light')
	-- vim.cmd('set background=dark')
	use 'itchyny/lightline.vim'
	use 'mengelbrecht/lightline-bufferline'
	vim.g.lightline = {
		component = {
			filename= '%F',
		},
		tabline = {
			left = { {'buffers'} },
			right = { {'close'} },
		},
		component_expand = {
			buffers = 'lightline#bufferline#buffers',
		},
		component_type = {
			buffers = 'tabsel',
		},
	}
	--------------------------------------

	--------------------------------------
	-- core
	--------------------------------------
	use 'bfredl/nvim-miniyank'
	vim.g.miniyank_filename = os.getenv("HOME") .. "/.miniyank.mpack"

	-- Enable submodes, used for window submode
	use 'Iron-E/nvim-libmodal'
	use 'DavidGamba/nvim-window-mode'

	use 'christoomey/vim-tmux-navigator'

	use 'editorconfig/editorconfig-vim'

	use 'neomake/neomake'
	vim.g.neomake_shellcheck_args = {'-fgcc'}
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
	require'dap-go'.setup {}
	require'dapui'.setup {}
	-- require'go'.setup {
	-- 	goimport = 'gopls', -- if set to 'gopls' will use golsp format
	-- 	gofmt = 'gopls', -- if set to gopls will use golsp format
	-- 	lsp_cfg = true,
	-- 	dap_debug = true,
	-- 	dap_debug_keymap = true,
	-- 	dap_debug_gui = true,
	-- }
	-- local protocol = require'vim.lsp.protocol'
	-- use {'sebdah/vim-delve', ft = {'go'} }
	vim.api.nvim_command("autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)")
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
	vim.g.UltiSnipsExpandTrigger="<tab>"
	if not vim.g.UltiSnipsSnippetDirectories then
		vim.g.UltiSnipsSnippetDirectories = { os.getenv("HOME") .. "/dotrc/vim-snippets" }
	else
		table.inser(vim.g.UltiSnipsSnippetDirectories, os.getenv("HOME") .. "/dotrc/vim-snippets")
	end
	vim.g.UltiSnipsJumpForwardTrigger="<tab>"
	vim.g.UltiSnipsJumpBackwardTrigger="<s-tab>"
	--------------------------------------

	--------------------------------------
	-- Completion
	--------------------------------------
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-nvim-lsp',
		},
	}
	-- Setup nvim-cmp
	local cmp = require'cmp'

	cmp.setup({
		snippet = {
			expand = function(args)
			-- For `ultisnips` user.
			vim.fn["UltiSnips#Anon"](args.body)
			end,
		},
		mapping = {
			['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
			['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
			-- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
			-- -- ['<C-y>'] = cmp.config.disable, -- remove the default `<C-y>` mapping.
			-- ['<CR>'] = cmp.mapping.confirm({ select = true }),

			['<CR>'] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			['<Tab>'] = cmp.mapping.select_next_item(),
			['<S-Tab>'] = cmp.mapping.select_prev_item(),
		},
		sources = cmp.config.sources({
			-- For ultisnips user.
			{ name = 'ultisnips' },

			{ name = 'nvim_lsp' },
			{ name = 'buffer' },
			{ name = 'path' },
			{ name = 'nvim_lua' },
		})
	})
	cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } } )
	--------------------------------------

	--------------------------------------
	-- Treesitter
	--------------------------------------
	use 'nvim-treesitter/nvim-treesitter'
	require'nvim-treesitter.configs'.setup {
		highlight             = {
			enable = true,
			additional_vim_regex_highlighting = true, -- fixes spell check on comments only
		},
		indent                = { enable = true },
		incremental_selection = { enable = true },
		textobjects           = { enable = true },
	}
	--------------------------------------

	--------------------------------------
	-- Editing
	--------------------------------------
	-- use 'LunarWatcher/auto-pairs'
	use 'tpope/vim-commentary'
	use 'tpope/vim-surround'

	-- Provides CoeRce MixedCase (crm), CoeRce camelCase (crc), CoeRce snake_case (crs), and CoeRce UPPER_CASE (cru)
	use 'tpope/vim-abolish'
	
	-- use 'junegunn/vim-easy-align'
	-- use 'vim-scripts/vis' -- Visual mode B

	-- " <leader>e to search/replace word under cursor
	-- use 'wincent/scalpel'
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
	use 'justinmk/vim-dirvish'
	-- use 'tpope/vim-vinegar'
	-- :NERDTreeToggle
	-- use 'scrooloose/nerdtree'

	use 'airblade/vim-gitgutter'
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
	
	-- Extra command pairs to do many things
	-- A mnemonic for the "a" commands is "args" and for the "q" commands is "quickfix"
	-- The mnemonic for y is that if you tilt it a bit it looks like a switch.
	use'tpope/vim-unimpaired'

	-- :SemanticHighlightToggle
	use 'jaxbot/semantic-highlight.vim'
	--------------------------------------

	--------------------------------------
	-- Language support
	--------------------------------------
	use { 'hashivim/vim-terraform' }
	use {'suoto/vim-antlr', ft = {'antlr4'} }
	--------------------------------------
end)
