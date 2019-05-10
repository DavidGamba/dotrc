" Install:
" mkdir -p ~/.config/nvim/autoload
" curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

let g:mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

"""""""""""""""""""""""""""""""""""""""
" Core
"""""""""""""""""""""""""""""""""""""""
" Extra command pairs to do many things
" A mnemonic for the "a" commands is "args" and for the "q" commands is "quickfix"
" The mnemonic for y is that if you tilt it a bit it looks like a switch.
Plug 'tpope/vim-unimpaired'

"""""""""""""""""""""""""""""""""""""""
" Completion
"""""""""""""""""""""""""""""""""""""""
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" Provides tag list to lsp so ctrl+t works
Plug 'ipod825/vim-tabdrop'

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'neomake/neomake'

"""""""""""""""""""""""""""""""""""""""
" Styling
"""""""""""""""""""""""""""""""""""""""
Plug 'morhetz/gruvbox'
Plug 'bling/vim-airline'
" Tagbar like symbol view | Not in use because gopls doesn't support symbols yet.
"Plug 'liuchengxu/vista.vim'

"""""""""""""""""""""""""""""""""""""""
" Text editing
"""""""""""""""""""""""""""""""""""""""
Plug 'tomtom/tcomment_vim'
" Provides ChangeSurround (cs<old><new>), ChangeSurroundTag (cst<new>),
" DeleteSurround (ds<old>), YourSurroundInParagraph (ysip<new>)
" In visual mode, provides Surround (S<new>)
Plug 'tpope/vim-surround'
" Provides CoeRce MixedCase (crm), CoeRce camelCase (crc), CoeRce snake_case (crs), and CoeRce UPPER_CASE (cru)
Plug 'tpope/vim-abolish'
Plug 'junegunn/vim-easy-align'


"""""""""""""""""""""""""""""""""""""""
" Tools
"""""""""""""""""""""""""""""""""""""""
" linediff provides: :Linediff
Plug 'AndrewRadev/linediff.vim'
Plug 'easymotion/vim-easymotion'
" Provides - :Explore
Plug 'justinmk/vim-dirvish'

"""""""""""""""""""""""""""""""""""""""
" Language support
"""""""""""""""""""""""""""""""""""""""
Plug 'hashivim/vim-terraform', { 'for': ['terraform'] }

" All of your Plugins must be added before the following line
call plug#end()            " required
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
" Core
"""""""""""""""""""""""""""""""""""""""

" Required for operations modifying multiple buffers like rename.
set hidden

" https://github.com/neovim/neovim/issues/2127
" Neovim doesn't check file changes after focus is lost
autocmd BufEnter,FocusGained * checktime

" Autosave
autocmd InsertLeave <buffer> silent write

" Write file on Make
set autowriteall

set clipboard+=unnamedplus

set undofile
set undodir=.
set backupdir=.
set inccommand=split

"set spellfile=~/vim-local-spell.utf-8.add

"""""""""""""""""""""""""""""""""""""""
" Completion
"""""""""""""""""""""""""""""""""""""""
set wildoptions=pum
"set complete=.,w,b,u,t,i,kspell

" neocomplete like
set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect
let g:deoplete#enable_at_startup = 1

set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'
" let g:echodoc#type = 'virtual'

autocmd! InsertLeave,BufWritePost * Neomake
let g:neomake_shellcheck_args = ['-fgcc']

" Launch gopls when Go files are in use
let g:LanguageClient_serverCommands = {
	\ 'go': ['gopls']
	\ }

function! GotoDef()
	TabdropPushTag
	call LanguageClient_textDocument_definition({'gotoCmd': 'Tabdrop'})
endfunction

function! GotoTypeDef()
	TabdropPushTag
	call LanguageClient_textDocument_typeDefinition({'gotoCmd': 'Tabdrop'})
endfunction

function! GotoImplementation()
	TabdropPushTag
	call LanguageClient_textDocument_implementation({'gotoCmd': 'Tabdrop'})
endfunction

function SetLSPShortcuts()

	" Always draw the signcolumn.
	setlocal signcolumn=yes

	nnoremap <C-]> :call GotoDef()<CR>
	nmap <C-t> :TabdropPopTag<Cr>

	nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
	nnoremap <leader>gd :call GotoDef()<CR>
	nnoremap <leader>lt :call GotoTypeDef()<CR>
	nnoremap <leader>li :call GotoImplementation()<CR>
	nnoremap <F2> :call LanguageClient#textDocument_rename()<CR>
	nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
	nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
	nnoremap gh :call LanguageClient#textDocument_hover()<CR>
	" nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
	nnoremap <leader>ls :call LanguageClient_workspace_symbol()<CR>
	nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
	nnoremap <leader>le :call LanguageClient#explainErrorAtPoint()<CR>
	nnoremap <leader>la :call LanguageClient_textDocument_codeAction()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType go call SetLSPShortcuts()
augroup END

let g:fzf_layout = { 'up': '~40%' }
nmap <C-p> :Files<CR>

"""""""""""""""""""""""""""""""""""""""
" Styling
"""""""""""""""""""""""""""""""""""""""
set termguicolors
hi Cursor guifg=green guibg=green
hi Cursor2 guifg=red guibg=red
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50
au VimLeave * set guicursor=a:block-blinkon0
set background=light

au VimLeave * set guicursor=a:block-blinkon0
set list                     " shows tabbed spaces
set listchars=tab:˲\ ,trail:·,extends:»,precedes:« " Unprintable chars mapping
" ▸ ˲ ˃ ˍ

set tabstop=2
" set expandtab
set shiftwidth=2
set softtabstop=2
set number
set textwidth=0

set wrap
set linebreak " Visually break long lines at 'breakat' character
set whichwrap=b,s,<,>
set foldmethod=syntax
set foldnestmax=1

set ignorecase
set smartcase

let g:gruvbox_italic=1
let g:gruvbox_contrast_light="hard"
colorscheme gruvbox

let g:airline#extensions#tabline#enabled = 1

"""""""""""""""""""""""""""""""""""""""
" Abbreviations
"""""""""""""""""""""""""""""""""""""""

iab <expr> dts strftime("%c")
iab ** •

"""""""""""""""""""""""""""""""""""""""
" Text Formatting
"""""""""""""""""""""""""""""""""""""""
xmap ga <Plug>(EasyAlign)

" search/replace the word under the cursor
nnoremap <leader>z :let @z = expand("<cword>")<cr>q:i%s/\C\v<<esc>"zpa>//g<esc>hi

" tComment with <C-/>
nnoremap  :TComment<CR>
vnoremap  :TComment<CR>"

" Increment/Decrement inside screen
nmap <leader>a <C-a>
nmap <leader>x <C-x>

"""""""""""""""""""""""""""""""""""""""
" Motions
"""""""""""""""""""""""""""""""""""""""

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
nmap s <Plug>(easymotion-s)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Quickly get out of the closign paren
inoremap <C-l><C-l> <ESC>la

" Make navigation more amenable to the long wrapping lines.
nnoremap k gk
nnoremap j gj

inoremap <buffer> <Up> <C-O>gk
inoremap <buffer> <Down> <C-O>gj

nmap <UP> <C-Y>
nmap <DOWN> <C-E>

" This maps Leader + e to exit terminal mode.
tnoremap <Leader>e <C-\><C-n>

if has('nvim')
	nmap <BS> <C-h>
endif

" Move around splits
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W>h
nmap <C-L> <C-W>l

" Resize splits {
	" alt + .
	nmap ® <C-W>>
	nmap <m-.> <C-W>>
	" alt + ,
	nmap ¬ <C-W><
	nmap <m-,> <C-W><
	" alt + >
	nmap ¾ <C-W>+
	nmap <m->> <C-W>+
	" alt + <
	nmap ¼ <C-W>-
	nmap <m-<> <C-W>-
" }

" yy copies a line, use Y for y$
nnoremap Y y$

" Keep visual selection after indentation in visual mode
vmap < <gv
vmap > >gv

" Show buffer list
nmap <m-b> :Buffers<CR>

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" Remove trailing spaces
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
" Indent entire file
nmap _= :call Preserve("normal gg=G")<CR>

" Buffer delete
nmap <leader>d :bp<bar>sp<bar>bn<bar>bd<CR>

" restore position in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

" Enter acts as C-y when there are drop down menu selections
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

if exists('g:loaded_surround')
    " vim-surround: q for `foo' and Q for ``foo''
    let b:surround_{char2nr('q')} = "‘\r’"
    let b:surround_{char2nr('Q')} = "“\r”"
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Golang
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType go set listchars=tab:\ \ ,trail:·,extends:»,precedes:« " Unprintable chars mapping

" Run gofmt and goimports on save
autocmd InsertLeave,BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terraform
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:terraform_fmt_on_save=1
let g:terraform_align=1
au FileType terraform call tcomment#type#Define('terraform', '# %s')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
