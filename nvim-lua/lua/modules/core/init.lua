vim.g.mapleader = ','

vim.cmd('set mouse=a')
vim.cmd('set hidden') -- Allow changing to another file with unsaved changes on the current file.
vim.cmd('set noswapfile')
vim.cmd('set clipboard+=unnamedplus')

-- https://github.com/neovim/neovim/issues/2127
-- Neovim doesn't check file changes after focus is lost
-- vim.cmd([[
-- 	autocmd BufEnter,FocusGained * checktime
-- ]], false)

-- Autosave
-- vim.cmd([[
-- 	autocmd InsertLeave <buffer> silent write
-- ]], false)

vim.cmd('set autowriteall') -- Write file on Make

vim.cmd('set undofile')
vim.cmd('set backupdir=.')
vim.cmd('set inccommand=split')
vim.cmd('set diffopt=internal,filler,closeoff,algorithm:minimal')
vim.cmd('set completeopt=menu,menuone,noselect')
vim.cmd('set shortmess+=c')

---------------------------------------
-- Styling
---------------------------------------
vim.cmd('set showtabline=2')
vim.cmd('set signcolumn=yes')
vim.cmd('set noshowmode')
vim.cmd('set termguicolors')
-- hi Cursor guifg=green guibg=green
-- hi Cursor2 guifg=red guibg=red
-- set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50
-- au VimLeave * set guicursor=a:block-blinkon0

vim.cmd('au VimLeave * set guicursor=a:block-blinkon0')
vim.cmd('set list') -- shows tabbed spaces
vim.cmd("set listchars=tab:˲\\ ,trail:·,extends:»,precedes:«") -- Unprintable chars mapping
-- ▸ ˲ ˃ ˍ

vim.cmd('set tabstop=2')
-- vim.cmd('set expandtab')
vim.cmd('set shiftwidth=2')
vim.cmd('set softtabstop=2')
vim.cmd('set number')
vim.cmd('set textwidth=0')

vim.cmd('set sidescroll=30') -- Jump several characters to the side instead of waiting one at a time.
vim.cmd('set nowrap')
vim.cmd('set linebreak') -- Visually break long lines at 'breakat' character
vim.cmd('set whichwrap=b,s,<,>')

-- Folding setup
-- set foldmethod=syntax
vim.cmd('set foldmethod=expr')
vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
vim.cmd('set foldnestmax=3')
vim.cmd('set nofoldenable')

vim.cmd('set ignorecase')
vim.cmd('set smartcase')
