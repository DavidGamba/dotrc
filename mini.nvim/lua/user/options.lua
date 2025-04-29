local opt = vim.opt

-- opt.fileencoding = "utf-8" -- the encoding written to a file

-- Allow changing to another file with unsaved changes on the current file.
-- Also required by toggleterm
opt.hidden = true
opt.swapfile = false

-- opt.clipboard:append "unnamedplus" -- allows neovim to access the system clipboard and auto write to it
-- opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

-- https://github.com/neovim/neovim/issues/2127
-- Neovim doesn't check file changes after focus is lost
-- vim.cmd([[
-- 	autocmd BufEnter,FocusGained * checktime
-- ]], false)

-- Autosave
-- vim.cmd([[
-- 	autocmd InsertLeave <buffer> silent write
-- ]], false)

opt.autowriteall = true -- Write file on Make
opt.undofile = true
opt.backupdir = "."
opt.inccommand = "split"
opt.diffopt = { "internal", "filler", "closeoff", "algorithm:minimal", "linematch:60" }
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("c")

opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window

---------------------------------------
-- Styling
---------------------------------------
opt.showtabline = 2
opt.signcolumn = "yes"
opt.showmode = false
opt.termguicolors = true
-- hi Cursor guifg=green guibg=green
-- hi Cursor2 guifg=red guibg=red
-- set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50
-- au VimLeave * set guicursor=a:block-blinkon0

vim.cmd("au VimLeave * set guicursor=a:block-blinkon0")
opt.list = true -- shows tabbed spaces
-- opt.listchars:append "tab: ˲"
opt.listchars:append("tab:˲ ")
opt.listchars:append("trail:·")
opt.listchars:append("extends:»")
opt.listchars:append("precedes:«")
opt.cursorline = true

-- vim.cmd("set listchars=tab:˲\\ ,trail:·,extends:»,precedes:«") -- Unprintable chars mapping
-- ▸ ˲ ˃ ˍ

opt.tabstop = 2
opt.expandtab = false
opt.shiftwidth = 2
opt.softtabstop = 2
opt.number = true
opt.textwidth = 0

opt.sidescroll = 30 -- Jump several characters to the side instead of waiting one at a time.
opt.scrolloff = 7

opt.wrap = true
opt.linebreak = true -- Visually break long lines at 'breakat' character
opt.whichwrap = "b,s,<,>"
opt.iskeyword:remove("-")
opt.iskeyword:remove("_")

-- Folding setup
-- set foldmethod=syntax
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldnestmax = 3
opt.foldenable = true
-- opt.foldcolumn = "auto:3" -- '1' shows the fold level, '0' shows nothing

opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 300 -- faster completion (4000ms default)

opt.spell = true

opt.sessionoptions:append("localoptions") -- Save localoptions to session file

vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("detect_d2", { clear = true }),
	desc = "Set filetype for *.d2 files",
	pattern = { "*.d2" },
	callback = function()
		vim.cmd("set filetype=d2")
	end,
})
