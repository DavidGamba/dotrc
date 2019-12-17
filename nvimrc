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

" Plug 'neovim/nvim-lsp'

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
call deoplete#custom#source('LanguageClient', 'max_menu_width', 150)
let g:deoplete#enable_at_startup = 1
" call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
if !exists("g:UltiSnipsSnippetDirectories")
  let g:UltiSnipsSnippetDirectories = ["/home/david/dotrc/vim-snippets"]
else
  let g:UltiSnipsSnippetDirectories += ["/home/david/dotrc/vim-snippets"]
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

endfunction()

augroup LSP
  autocmd!
  autocmd FileType go call SetLSPShortcuts()
augroup END

" Implemented methods can be found in runtime/lua/vim/lsp/buf.lua
" call nvim_lsp#setup("gopls", {})
" autocmd Filetype rust,python,go,c,cpp setl omnifunc=v:lua.vim.lsp.omnifunc
" nnoremap <silent> gld <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gli  <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> gs  <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> glt  <cmd>lua vim.lsp.buf.type_definition()<CR>

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

set nowrap
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

" Increment/Decrement inside screen <C-i> <C-x>
nmap <C-i> <C-a>

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
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

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
