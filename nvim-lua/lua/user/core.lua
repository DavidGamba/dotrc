local o = vim.opt

o.fileencoding = "utf-8" -- the encoding written to a file
o.mouse = "a"

-- Allow changing to another file with unsaved changes on the current file.
-- Also required by toggleterm
o.hidden = true
o.swapfile = false

o.clipboard :append "unnamedplus" -- allows neovim to access the system clipboard
-- o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

-- https://github.com/neovim/neovim/issues/2127
-- Neovim doesn't check file changes after focus is lost
-- vim.cmd([[
-- 	autocmd BufEnter,FocusGained * checktime
-- ]], false)

-- Autosave
-- vim.cmd([[
-- 	autocmd InsertLeave <buffer> silent write
-- ]], false)

o.autowriteall = true -- Write file on Make
o.undofile = true
o.backupdir = "."
o.inccommand = "split"

o.diffopt = { "internal", "filler", "closeoff", "algorithm:minimal" }
o.completeopt = { "menu", "menuone", "noselect" }
o.shortmess :append "c"

o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window

---------------------------------------
-- Styling
---------------------------------------
o.showtabline = 2
o.signcolumn = "yes"
o.showmode = false
o.termguicolors = true
-- hi Cursor guifg=green guibg=green
-- hi Cursor2 guifg=red guibg=red
-- set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50
-- au VimLeave * set guicursor=a:block-blinkon0

vim.cmd('au VimLeave * set guicursor=a:block-blinkon0')
o.list = true -- shows tabbed spaces
-- o.listchars:append "tab: ˲"
o.listchars:append "tab:˲ "
o.listchars:append "trail:·"
o.listchars:append "extends:»"
o.listchars:append "precedes:«"

-- vim.cmd("set listchars=tab:˲\\ ,trail:·,extends:»,precedes:«") -- Unprintable chars mapping
-- ▸ ˲ ˃ ˍ

o.tabstop = 2
o.expandtab = false
o.shiftwidth = 2
o.softtabstop = 2
o.number = true
o.textwidth = 0

o.sidescroll = 30 -- Jump several characters to the side instead of waiting one at a time.
o.scrolloff = 3

o.wrap = false
o.linebreak = true -- Visually break long lines at 'breakat' character
o.whichwrap = "b,s,<,>"
o.iskeyword :remove "-"
o.iskeyword :remove "_"

-- Folding setup
-- set foldmethod=syntax
o.foldmethod = "expr"
vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
o.foldnestmax = 3
o.foldenable = false

o.ignorecase = true
o.smartcase = true

vim.api.nvim_command("autocmd FileType asciidoc set expandtab")

o.updatetime = 300 -- faster completion (4000ms default)

o.spell = true

o.sessionoptions:append("localoptions")       -- Save localoptions to session file
