" mkdir -p ~/.nvim/autoload
" curl -fLo ~/.nvim/autoload/plug.vim \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

let g:mapleader = ","

" set the runtime path to include Vundle and initialize
call plug#begin('~/.nvim/plugged')

" Sane defaults
Plug 'tpope/vim-sensible'

" Completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
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
Plug 'maxbrunsfeld/vim-yankstack'
let g:yankstack_map_keys = 0
nmap ð <Plug>yankstack_substitute_older_paste
nmap Ð <Plug>yankstack_substitute_newer_paste

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" close VIM if NERDTree is the only buffer left
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'Townk/vim-autoclose'

" Provides ChangeSurround (cs<old><new>), ChangeSurroundTag (cst<new>),
" DeleteSurround (ds<old>), YourSurroundInParagraph (ysip<new>)
" In visual mode, provides Surround (S<new>)
Plug 'tpope/vim-surround'

" Provides CoeRce MixedCase (crm), CoeRce camelCase (crc), CoeRce snake_case (crs), and CoeRce UPPER_CASE (cru)
Plug 'tpope/vim-abolish'

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

Plug 'scrooloose/syntastic'
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

Plug 'fatih/vim-go'
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>i <Plug>(go-install)
"au FileType go nmap <leader>c <Plug>(go-coverage)

Plug 'majutsushi/tagbar'
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-easytags'

Plug 'vim-scripts/SyntaxRange'

Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'derekwyatt/vim-scala', { 'for': ['scala', 'html'] }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'gre/play2vim', { 'for': ['play2-routes', 'play2-conf', 'html'] }
" Plug 'dahu/vim-asciidoc', { 'for': 'asciidoc' }
Plug 'DavidGamba/vim-asciidoc', { 'for': 'asciidoc', 'branch': 'clean-arguments' }
Plug 'dahu/vimple', { 'for': 'asciidoc' }
let vimple_init_vn = 0
Plug 'dahu/Asif', { 'for': 'asciidoc' }

" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

colorscheme github
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

" Save with ,w
noremap <leader>w :update<CR>

set clipboard=unnamedplus

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

  " Move around buffers
  nmap <C-J> <C-W><C-J>
  nmap <C-K> <C-W><C-K>
  nmap <C-H> :bp<CR>
  nmap <C-L> :bn<CR>

  " yy copies a line, use Y for y$
  nnoremap Y y$

  " Keep visual selection after indentation in visual mode
  vmap < <gv
  vmap > >gv

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

" Find files without extention in their filename {
    nmap <leader>g :call Find_by_ext()<CR>
    function! Find_by_ext()
        let b:my_ext=0
        let b:my_ext_len=4 " modify this value after number of extentions
        let cfile = expand("<cfile>")
        for ext in ["",".pl", ".pm", ".tex"]
            if findfile(cfile . ext ) != ''
                let b:my_ext = 0
                exec "tabnew" findfile(cfile . ext )
                break
            else
                let b:my_ext=b:my_ext+1
                if b:my_ext >= b:my_ext_len
                    echohl ErrorMsg
                    echomsg cfile . " not found in path"
                    echohl NONE
                    let b:my_ext = 0
                    break
                endif
            endif
        endfor
    endfunction
"}

set complete=.,w,b,u,t,i
set autoread

autocmd FileType yaml setlocal ts=3 sts=3 sw=3 expandtab
autocmd FileType asciidoc :compiler asciidoctor | setlocal complete+=kspell
command! Perl read $HOME/dotrc/vim_templates/perl.pl
command! Ruby read $HOME/dotrc/vim_templates/ruby.rb
command! Scala read $HOME/dotrc/vim_templates/scala.scala
