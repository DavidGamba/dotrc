" mkdir -p ~/.nvim/autoload
" curl -fLo ~/.nvim/autoload/plug.vim \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

let g:mapleader = ","

" set the runtime path to include Vundle and initialize
call plug#begin('~/.config/nvim/plugged')

" Sane defaults
Plug 'tpope/vim-sensible'

" Completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer' }
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']

" Motion
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
nmap s <Plug>(easymotion-s)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

hi link EasyMotionTarget2First ErrorMsg
hi link EasyMotionTarget2Second ErrorMsg

hi link EasyMotionMoveHL ErrorMsg
" Plug 'justinmk/vim-sneak'

" Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsListSnippets="<leader><Tab>"

" File search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" Coloring
Plug 'junegunn/rainbow_parentheses.vim'
autocmd VimEnter * RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']']]

Plug 'endel/vim-github-colorscheme'
" Plug 'chriskempson/base16'

" Status line
Plug 'bling/vim-airline'
let g:airline#extensions#tabline#enabled = 1

" meta-p meta-shift-p
"Plug 'maxbrunsfeld/vim-yankstack'
"let g:yankstack_map_keys = 0
"nmap ð <Plug>yankstack_substitute_older_paste
"nmap Ð <Plug>yankstack_substitute_newer_paste

"Plug 'simnalamburt/vim-mundo'
" alt+u
"nnoremap õ :GundoToggle<CR>

"Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" close VIM if NERDTree is the only buffer left
"autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Smarter repeat
Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-git'
"Plug 'tpope/vim-fugitive'
" Improved netrw behaviour
Plug 'tpope/vim-vinegar'
Plug 'Townk/vim-autoclose'

" Git
Plug 'airblade/vim-gitgutter'

" Diff
Plug 'AndrewRadev/linediff.vim'

" Provides ChangeSurround (cs<old><new>), ChangeSurroundTag (cst<new>),
" DeleteSurround (ds<old>), YourSurroundInParagraph (ysip<new>)
" In visual mode, provides Surround (S<new>)
Plug 'tpope/vim-surround'

" Provides CoeRce MixedCase (crm), CoeRce camelCase (crc), CoeRce snake_case (crs), and CoeRce UPPER_CASE (cru)
Plug 'tpope/vim-abolish'

" Show registers
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-easy-align'
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|->\|>' },
\ }
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" tComment
Plug 'tomtom/tcomment_vim'
nnoremap ,c :TComment<CR>
vnoremap ,c :TComment<CR>"

" Plug 'scrooloose/syntastic'
" let g:syntastic_ruby_checkers = ['rubocop', 'mri']
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_warning_symbol = '⚠'
" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1

Plug 'benekastah/neomake'
autocmd! BufWritePost * Neomake

" Plug 'fatih/vim-go', { 'for': 'go', 'commit': '5573e9c' }
Plug 'fatih/vim-go', { 'for': 'go' }
" Plug '~/code/personal/git/vim-go'
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>gc <Plug>(go-coverage)
au FileType go nmap <leader>gi <Plug>(go-install)
au FileType go nmap <leader>i <Plug>(go-info)
" au FileType go nmap <leader>s <Plug>(go-implements)
au FileType go nmap <leader>e <Plug>(go-rename)
au FileType go map ]l :lne<CR>
au FileType go map [l :lp<CR>
" let g:go_fmt_command = "goimports"
" Fixes the folds closed on save issue
" g:go_fmt_experimental = 1
" It doesn't let me see the errors
" let g:go_auto_type_info = 1
au BufRead,BufNewFile *.gtpl set filetype=gohtmltmpl

Plug 'majutsushi/tagbar'
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-easytags'

Plug 'vim-scripts/SyntaxRange', { 'for': [ 'html', 'asciidoc' ] }

Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
" Plug 'zxiest/vim-ruby', { 'for': 'ruby' }
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1




Plug 'derekwyatt/vim-scala', { 'for': ['scala', 'html'] }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'gre/play2vim', { 'for': ['play2-routes', 'play2-conf', 'html'] }
"Plug 'DavidGamba/vim-asciidoc', { 'for': 'asciidoc', 'branch': 'clean-arguments' }
"Plug '~/code/personal/git/vim-asciidoc', {'for': 'asciidoc' }
Plug 'dahu/Asif', { 'for': 'asciidoc' } | Plug 'dahu/vimple', { 'for': 'asciidoc' } | Plug 'dahu/vim-asciidoc', { 'for': 'asciidoc' }
let vimple_init_vn = 0

" Use with :Voom
Plug 'voom'
let g:voom_ft_modes = {'asciidoc': 'asciidoc'}

" All of your Plugins must be added before the following line
call plug#end()            " required

" https://github.com/neovim/neovim/issues/2127
" Neovim doesn't check file changes after focus is lost
autocmd BufEnter,FocusGained * checktime

colorscheme default
set background=light
set list                     " shows tabbed spaces
set listchars=tab:▸\ ,trail:·,extends:»,precedes:« " Unprintable chars mapping
au FileType go set listchars=tab:\ \ ,trail:·,extends:»,precedes:« " Unprintable chars mapping
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set number
set ignorecase
set smartcase

set wrap
set linebreak " Visually break long lines at 'breakat' character
set whichwrap=b,s,<,>
set foldmethod=syntax
set foldnestmax=1

set clipboard+=unnamedplus

set undofile
set undodir=.
set backupdir=.

" Save with ,w
noremap <leader>w :update<CR>

" search/replace the word under the cursor
nnoremap <leader>z :let @z = expand("<cword>")<cr>q:i%s/\C\v<<esc>"zpa>//g<esc>hi

set tags=./.tags;,~/.vimtags

" Paste using set paste
inoremap <leader>v <ESC>:set paste<CR>"*p:set nopaste<CR>

" Quickly get out of the closign paren
inoremap <C-l><C-l> <ESC>la

" Navigation {
  " Make navigation more amenable to the long wrapping lines.
  nnoremap k gk
  nnoremap j gj
  nnoremap <buffer> 0 g0
  nnoremap <buffer> ^ g^
  nnoremap <buffer> $ g$
  nnoremap <buffer> D dg$
  nnoremap <buffer> C cg$
  nnoremap <buffer> A g$a

  inoremap <buffer> <Up> <C-O>gk
  inoremap <buffer> <Down> <C-O>gj

  nmap <UP> <C-Y>
  nmap <DOWN> <C-E>

  " This maps Leader + e to exit terminal mode.
  tnoremap <Leader>e <C-\><C-n>

  if has('nvim')
    nmap <BS> <C-h>
  endif

  " Move around buffers
  nmap <C-J> <C-W><C-J>
  nmap <C-K> <C-W><C-K>
  " alt + h
  nmap è :bp<CR>:if &buftype ==# 'quickfix'<Bar>:bp<Bar>endif<CR>
  nmap <m-h> :bp<CR>:if &buftype ==# 'quickfix'<Bar>:bp<Bar>endif<CR>
  " alt + l
  nmap ì :bn<CR>:if &buftype ==# 'quickfix'<Bar>:bn<Bar>endif<CR>
  nmap <m-l> :bn<CR>:if &buftype ==# 'quickfix'<Bar>:bn<Bar>endif<CR>
  nmap <C-H> <C-W>h
  nmap <C-L> <C-W>l
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

  " yy copies a line, use Y for y$
  nnoremap Y y$

  " Keep visual selection after indentation in visual mode
  vmap < <gv
  vmap > >gv

" Increment/Decrement inside screen
nmap <leader>a <C-a>
nmap <leader>x <C-x>

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

" Select Buffer
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>
nnoremap <silent> <Leader>t :call fzf#run()<CR>

" restore position in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

" Enter acts as C-y when there are drop down menu selections
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Find files without extention in their filename
set suffixesadd+=.pl,.pm,.text

set complete=.,w,b,u,t,i,kspell
set autoread
set spellfile=~/vim-local-spell.utf-8.add

autocmd BufWritePost *.go normal! zO
autocmd FileType yaml setlocal ts=3 sts=3 sw=3 expandtab
autocmd FileType asciidoc :compiler asciidoctor | setlocal spell | inoremap <leader>u [.underline]#<ESC>ea#<ESC> | nnoremap <leader>u i[.underline]#<ESC>ea#<ESC>
command! Perl read $HOME/dotrc/vim_templates/perl.pl
command! Ruby read $HOME/dotrc/vim_templates/ruby.rb
command! Scala read $HOME/dotrc/vim_templates/scala.scala
