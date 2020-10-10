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

" Enable submodes, used for window submode
Plug 'Iron-E/nvim-libmodal'
" Plug 'Iron-E/nvim-libmodal', {'branch': 'bugfix/0.6.2'}
" Plug '/home/david/general/code/nvim-window-mode'
Plug 'DavidGamba/nvim-window-mode'
Plug 'Iron-E/nvim-tabmode'

"""""""""""""""""""""""""""""""""""""""
" Completion
"""""""""""""""""""""""""""""""""""""""
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" Provides tag list to lsp so ctrl+t works
Plug 'ipod825/vim-tabdrop'

" Plug 'neovim/nvim-lspconfig'

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'neomake/neomake'

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

"""""""""""""""""""""""""""""""""""""""
" Styling
"""""""""""""""""""""""""""""""""""""""
Plug 'morhetz/gruvbox'
Plug 'bling/vim-airline'
" Tagbar like symbol view | Not in use because gopls doesn't support symbols yet.
"Plug 'liuchengxu/vista.vim'

Plug 'jaxbot/semantic-highlight.vim'

Plug 'wfxr/minimap.vim'

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
Plug 'vim-scripts/vis' " Visual mode B

" <leader>e to search/replace word under cursor
Plug 'wincent/scalpel'


"""""""""""""""""""""""""""""""""""""""
" Tools
"""""""""""""""""""""""""""""""""""""""
" linediff provides: :Linediff
Plug 'AndrewRadev/linediff.vim'
Plug 'easymotion/vim-easymotion'
" Provides - :Explore
Plug 'justinmk/vim-dirvish'
" Plug 'tpope/vim-vinegar'
" Provides - :NERDTreeToggle
Plug 'scrooloose/nerdtree'

Plug 'airblade/vim-gitgutter'

"""""""""""""""""""""""""""""""""""""""
" Language support
"""""""""""""""""""""""""""""""""""""""
Plug 'hashivim/vim-terraform', { 'for': ['terraform'] }
Plug 'suoto/vim-antlr', { 'for': ['antlr4'] }

" All of your Plugins must be added before the following line
call plug#end()            " required
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
" Core
"""""""""""""""""""""""""""""""""""""""

command! Config execute ":e $MYVIMRC"
command! Reload execute "source $MYVIMRC"

set mouse=a

set hidden " Allow changing to another file with unsaved changes on the current file.
set noswapfile

" https://github.com/neovim/neovim/issues/2127
" Neovim doesn't check file changes after focus is lost
autocmd BufEnter,FocusGained * checktime

" Autosave
autocmd InsertLeave <buffer> silent write

" Write file on Make
" set autowriteall

set clipboard+=unnamedplus

" TODO: check help directory
set undofile
set undodir=.
set backupdir=.
set inccommand=split

" autochdir conflicts with dirvish
" https://github.com/justinmk/vim-dirvish/issues/19
set noautochdir
augroup auto_ch_dir
	autocmd!
	autocmd BufEnter * silent! lcd %:p:h
augroup END

set spell
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
call deoplete#custom#source('LanguageClient', 'max_menu_width', 150)
let g:deoplete#enable_at_startup = 1
" call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
if !exists("g:UltiSnipsSnippetDirectories")
  let g:UltiSnipsSnippetDirectories = [$HOME ."/dotrc/vim-snippets"]
else
  let g:UltiSnipsSnippetDirectories += [$HOME ."/dotrc/vim-snippets"]
endif
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"

set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'
" let g:echodoc#type = 'virtual'

autocmd! BufWritePost * Neomake
let g:neomake_shellcheck_args = ['-fgcc']

" Launch gopls when Go files are in use
let g:LanguageClient_serverCommands = {
	\ 'go': ['gopls']
	\ }

nnoremap <F2> :%s/<C-R>///g<left><left>

function! GotoDef()
	" LanguageClient_textDocument_definition()
	call MyGoToDefinition()
	" TabdropPushTag
	" call LanguageClient_textDocument_definition({'gotoCmd': 'Tabdrop'})
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

	nnoremap <C-]> :call MyGoToDefinition()<CR>
	" nmap <C-t> :TabdropPopTag<Cr>

	nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
	nnoremap gd :call GotoDef()<CR>
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
	nnoremap ga :call LanguageClient_textDocument_codeAction()<CR>
	vnoremap <leader>a :call LanguageClient_textDocument_codeAction()<CR>
	nnoremap <leader>lh :call LanguageClient_textDocument_documentHighlight()<CR>

	" Rename - rn => rename
	noremap <leader>rn :call LanguageClient#textDocument_rename()<CR>

	" Rename - rc => rename camelCase
	noremap <leader>rc :call LanguageClient#textDocument_rename(
							\ {'newName': Abolish.camelcase(expand('<cword>'))})<CR>

	" Rename - rs => rename snake_case
	noremap <leader>rs :call LanguageClient#textDocument_rename(
		\ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>

	" Rename - ru => rename UPPERCASE
	noremap <leader>ru :call LanguageClient#textDocument_rename(
		\ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>

	nnoremap <leader>t :!go test ./...<CR>

endfunction()

" https://github.com/neovim/nvim-lsp#gopls
" lua << EOF
" require'nvim_lsp'.gopls.setup{}
" EOF

function SetNativeLSPShortcuts()
" Implemented methods can be found in runtime/lua/vim/lsp/buf.lua
" https://neovim.io/doc/user/lsp.html
" call nvim_lsp#setup("gopls", {})
" autocmd Filetype rust,python,go,c,cpp setl omnifunc=v:lua.vim.lsp.omnifunc
	autocmd Filetype go setlocal omnifunc=v:lua.vim.lsp.omnifunc()
	nnoremap <silent> gld <cmd>lua vim.lsp.buf.declaration()<CR>
	nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> K <cmd>lua vim.lsp.buf.peek_definition()<CR>
	nnoremap <silent> gli  <cmd>lua vim.lsp.buf.implementation()<CR>
	nnoremap <silent> gs  <cmd>lua vim.lsp.buf.signature_help()<CR>
	nnoremap <silent> glt  <cmd>lua vim.lsp.buf.type_definition()<CR>
	nnoremap <silent> gr  <cmd>lua vim.lsp.buf.references()<CR>
	nnoremap <silent> ga  <cmd>lua vim.lsp.buf.code_action()<CR>
	vnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
	nnoremap <F2> <cmd>lua vim.lsp.buf.rename()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType go call SetLSPShortcuts()
  " autocmd FileType go call SetNativeLSPShortcuts()
augroup END

let g:fzf_layout = { 'up': '~40%' }
nmap <C-p> :Files<CR>
" https://github.com/ryanoasis/nerd-fonts/wiki/Codepoint-Conflicts
" echo $'\uf016'
" 📂 📄   
call dirvish#add_icon_fn({p -> p[-1:]=='/'?'📂':'📄'})
" call dirvish#add_icon_fn({p -> p[-1:]=='/'?'':''})

"""""""""""""""""""""""""""""""""""""""
" Styling
"""""""""""""""""""""""""""""""""""""""
set noshowmode
set termguicolors
hi Cursor guifg=green guibg=green
hi Cursor2 guifg=red guibg=red
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50
au VimLeave * set guicursor=a:block-blinkon0
set background=dark
" set background=light

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

set sidescroll=30 " Jump several characters to the side instead of waiting one at a time.
set nowrap
set linebreak " Visually break long lines at 'breakat' character
set whichwrap=b,s,<,>
set foldmethod=syntax
set foldnestmax=3
set nofoldenable

set ignorecase
set smartcase

let g:gruvbox_italic=1
let g:gruvbox_contrast_light="hard"
colorscheme gruvbox

let g:airline#extensions#tabline#enabled = 1
let g:airline_section_c = '%F'

" Keep cursor in place after yank
" https://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"
vnoremap Y myY`y

hi MyNormalNC ctermbg=darkblue guibg='#32302f'
set winhighlight=NormalNC:MyNormalNC

"""""""""""""""""""""""""""""""""""""""
" Abbreviations
"""""""""""""""""""""""""""""""""""""""

iab <expr> dts strftime("%c")
iab ** •

"""""""""""""""""""""""""""""""""""""""
" Text Formatting
"""""""""""""""""""""""""""""""""""""""
xmap ga <Plug>(EasyAlign)

" tComment with <C-/>
nnoremap  :TComment<CR>
vnoremap  :TComment<CR>"

" Increment/Decrement inside screen <C-i> <C-x>
nmap <C-i> <C-a>

"""""""""""""""""""""""""""""""""""""""
" Motions
"""""""""""""""""""""""""""""""""""""""

inoremap jj <esc>

" List buffers
" Mnemonic move-buffer
nmap <c-m> :Buffers<CR>

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
nmap <C-J> :wincmd j<CR>
nmap <C-K> :wincmd k<CR>
nmap <C-H> :wincmd h<CR>
nmap <C-L> :wincmd l<CR>

if !hasmapto('<Plug>WindowmodeEnter')
	silent! nmap <unique> <Leader>w <Plug>WindowmodeEnter
endif

" " Resize splits {
" 	" alt + .
" 	nmap ® <C-W>>
" 	nmap <m-.> <C-W>>
" 	" alt + ,
" 	nmap ¬ <C-W><
" 	nmap <m-,> <C-W><
" 	" alt + >
" 	nmap ¾ <C-W>+
" 	nmap <m->> <C-W>+
" 	" alt + <
" 	nmap ¼ <C-W>-
" 	nmap <m-<> <C-W>-
" " }

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

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <leader>h <Plug>(GitGutterPreviewHunk)
let g:gitgutter_preview_win_floating = 0

" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Window submode
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" " A message will appear in the message line when you're in a submode
" " and stay there until the mode has existed.
" let g:submode_always_show_submode = 1
"
" call submode#enter_with('window', 'n', '', '<C-w>')
"
" " Note: <C-c> will also get you out to the mode without this mapping.
" " Note: <C-[> also behaves as <ESC>
" call submode#leave_with('window', 'n', '', '<ESC>')
"
" " Go through every letter
" for key in ['a','b','c','d','e','f','g','h','i','j','k','l','m',
" \           'n','o','p','q','r','s','t','u','v','w','x','y','z']
"   " maps lowercase, uppercase and <C-key>
"   call submode#map('window', 'n', '', key, '<C-w>' . key)
"   call submode#map('window', 'n', '', toupper(key), '<C-w>' . toupper(key))
"   call submode#map('window', 'n', '', '<C-' . key . '>', '<C-w>' . '<C-'.key . '>')
" endfor
" " Go through symbols. Sadly, '|', not supported in submode plugin.
" for key in ['=','_','+','-','<','>']
"   call submode#map('window', 'n', '', key, '<C-w>' . key)
" endfor
"
" " Old way, just in case.
" nnoremap <Leader>w <C-w>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

function! MyGoToDefinition(...) abort
  " ref: https://github.com/davidhalter/jedi-vim/blob/master/pythonx/jedi_vim.py#L329-L345

  " Get the current position
  let l:fname = expand('%:p')
  let l:line = line(".")
  let l:col = col(".")
  let l:word = expand("<cword>")

  " Call the original function to jump to the definition
  let l:result = LanguageClient_runSync(
                  \ 'LanguageClient#textDocument_definition', {
                  \ 'handle': v:true,
                  \ })

  " Get the position of definition
  let l:jump_fname = expand('%:p')
  let l:jump_line = line(".")
  let l:jump_col = col(".")

  " If the position is the same as previous, ignore the jump action
  if l:fname == l:jump_fname && l:line == l:jump_line
    return
  endif

  " Workaround: Jump to origial file. If the function is in rust, there is a
  " way to ignore the behaviour
  if &modified
    exec 'hide edit'  l:fname
  else
    exec 'edit' l:fname
  endif
  call cursor(l:line, l:col)

  " Store the original setting
  let l:ori_wildignore = &wildignore
  let l:ori_tags = &tags

  " Write a temp tags file
  let l:temp_tags_fname = tempname()
  let l:temp_tags_content = printf("%s\t%s\t%s", l:word, l:jump_fname,
      \ printf("call cursor(%d, %d)", l:jump_line, l:jump_col+1))
  call writefile([l:temp_tags_content], l:temp_tags_fname)

  " Set temporary new setting
  set wildignore=
  let &tags = l:temp_tags_fname

  " Add to new stack
  execute ":tjump " . l:word

  " Restore original setting
  let &tags = l:ori_tags
  let &wildignore = l:ori_wildignore

  " Remove temporary file
  if filereadable(l:temp_tags_fname)
    call delete(l:temp_tags_fname, "rf")
  endif
endfunction
