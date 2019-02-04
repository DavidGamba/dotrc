" https://github.com/junegunn/vim-plug
"
" mkdir -p ~/.config/nvim/autoload
" curl -fLo ~/.config/nvim/autoload/plug.vim \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

let g:mapleader = ","

" set the runtime path to include Vundle and initialize
call plug#begin('~/.local/share/nvim/plugged')

" https://github.com/sebdah/dotfiles/blob/master/config/nvim/init.vim
" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Status line
Plug 'bling/vim-airline'
" File search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Tag navigation
Plug 'majutsushi/tagbar'
" Move around
Plug 'easymotion/vim-easymotion'
" Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Repeat more things with .
Plug 'tpope/vim-repeat'
" Yank ring
Plug 'bfredl/nvim-miniyank'
" Extra command pairs to do many things
" A mnemonic for the "a" commands is "args" and for the "q" commands is "quickfix"
" The mnemonic for y is that if you tilt it a bit it looks like a switch.
Plug 'tpope/vim-unimpaired'

" Nerd tree alternative
Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'Townk/vim-autoclose'
Plug 'kana/vim-textobj-user'
Plug 'reedes/vim-textobj-quote'
Plug 'reedes/vim-wordy'
Plug 'vim-scripts/VOoM'
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/linediff.vim'
Plug 'tpope/vim-surround'

" Provides CoeRce MixedCase (crm), CoeRce camelCase (crc), CoeRce snake_case (crs), and CoeRce UPPER_CASE (cru)
Plug 'tpope/vim-abolish'
Plug 'junegunn/vim-easy-align'
Plug 'tomtom/tcomment_vim'
Plug 'benekastah/neomake'

""""""""""""""""""""""""""""""""""""
" Language support
""""""""""""""""""""""""""""""""""""
" Go
Plug 'zchee/deoplete-go', { 'for': 'go', 'do': 'make'}
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'mdempsky/gocode', { 'for': 'go' }
" Plug 'nsf/gocode', { 'for': 'go' }
" Yaml
Plug 'pearofducks/ansible-vim', { 'for': 'yaml' }
" Asciidoc
Plug 'vim-scripts/SyntaxRange', { 'for': [ 'html', 'asciidoc' ] }
Plug 'dahu/Asif', { 'for': 'asciidoc' } | Plug 'dahu/vimple', { 'for': 'asciidoc' } | Plug 'dahu/vim-asciidoc', { 'for': 'asciidoc' }
" Toml
Plug 'cespare/vim-toml', { 'for': 'toml' }
" Puppet
Plug 'puppetlabs/puppet-syntax-vim', { 'for': 'puppet' }
" Ruby
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
" Python
Plug 'Yggdroot/indentLine', { 'for': 'python' }
" HTML
Plug 'othree/html5.vim', { 'for': 'html' }
" Terraform
Plug 'hashivim/vim-terraform', { 'for': ['terraform'] }

" Coloring
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'morhetz/gruvbox'

call plug#end()            " required

" Plug '907th/vim-auto-save'
" let g:auto_save = 1  " enable AutoSave on Vim startup
" let g:auto_save_silent = 1  " do not display the auto-save notification
" let g:auto_save_events = ["InsertLeave", "TextChanged"]

" Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
" Required for operations modifying multiple buffers like rename.
" set hidden
" Automatically start language servers.
" let g:LanguageClient_autoStart = 1
" let g:LanguageClient_serverCommands = {
"     \ 'go': ['/home/david/general/code/go/bin/go-langserver'],
"     \ }
" Plug 'roxma/nvim-completion-manager'
" " LSP Go commands
" au FileType go nnoremap <silent> <leader>i :call LanguageClient_textDocument_hover()<CR>
" au FileType go nnoremap <silent> <leader>e :call LanguageClient_textDocument_rename()<CR>
" " au FileType go nnoremap <silent> <leader>l :call LanguageClient_textDocument_documentSymbol()<CR>
" au FileType go nnoremap <silent> <leader>l :call LanguageClient_workspace_symbol()<CR>
" au FileType go nnoremap <silent> <leader>u :call LanguageClient_textDocument_references()<CR>
" au FileType go nnoremap <silent> <leader>d :call LanguageClient_textDocument_definition()<CR>
" " au FileType go nnoremap <silent> <leader>d :call LanguageClient_setLoggingLevel('DEBUG')<CR>
" au FileType go map ]l :lne<CR>
" au FileType go map [l :lp<CR>

" Sane defaults
" Plug 'tpope/vim-sensible'

" " Completion
" Plug 'Valloric/YouCompleteMe', { 'for': 'python', 'do': './install.py --gocode-completer' }
" let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
"
" Deoplete {
let g:deoplete#enable_at_startup = 1
" Plug 'zchee/deoplete-jedi'
" }

" Motion
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
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsListSnippets="<leader>l"
if !exists("g:UltiSnipsSnippetDirectories")
  let g:UltiSnipsSnippetDirectories = ["/home/david/dotrc/vim-snippets"]
else
  let g:UltiSnipsSnippetDirectories += ["/home/david/dotrc/vim-snippets"]
endif

" File search

if executable('rg')
    set grepprg=rg\ --no-heading\ --hidden\ --vimgrep\ -i
    set grepformat=%f:%l:%c:%m
else
    set grepprg=git\ grep\ -n
endif

" Coloring

autocmd VimEnter * RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']']]

" Plug 'machakann/vim-highlightedyank'

" Colorscheme
" Plug 'freeo/vim-kalisi'
let g:gruvbox_italic=1
let g:gruvbox_contrast_light="hard"
" Plug 'justinmk/molokai'
" Horrible!
" Plug 'nathanaelkane/vim-indent-guides', { 'for': 'python' }
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_start_level = 2
" let g:indent_guides_guide_size = 1
" let g:indent_guides_auto_colors = 1
" let g:indent_guides_color_change_percent = 10

let g:indentLine_enabled = 1
" let g:indentLine_char = '┆│ ⎸ ▏'
let g:indentLine_char = ' ̩'
let g:indentLine_char = 'ˈ'

" Status line
let g:airline#extensions#tabline#enabled = 1

" meta-p meta-shift-p
"Plug 'maxbrunsfeld/vim-yankstack'
"let g:yankstack_map_keys = 0
"nmap ð <Plug>yankstack_substitute_older_paste
"nmap Ð <Plug>yankstack_substitute_newer_paste
nmap <M-p> <Plug>(miniyank-startput)
nmap <M-P> <Plug>(miniyank-startPut)
nmap <M-n> <Plug>(miniyank-cycle)


"Plug 'simnalamburt/vim-mundo'
" alt+u
"nnoremap õ :GundoToggle<CR>

"Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" close VIM if NERDTree is the only buffer left
"autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Smarter repeat
"Plug 'tpope/vim-git'
"Plug 'tpope/vim-fugitive'
" Improved netrw behaviour

" Writting aids
autocmd FileType asciidoc let g:textobj#quote#educate = 1
autocmd FileType asciidoc let g:textobj#quote#matchit = 1

" Use with:
"   :Wordy weak
"   :Wordy redundant
"   :Wordy problematic
" Outline
let g:voom_ft_modes = {'asciidoc': 'asciidoc'}

" Git

" Diff - :Linediff

" Provides ChangeSurround (cs<old><new>), ChangeSurroundTag (cst<new>),
" DeleteSurround (ds<old>), YourSurroundInParagraph (ysip<new>)
" In visual mode, provides Surround (S<new>)


" Show registers
" Plug 'junegunn/vim-peekaboo'
" let g:easy_align_delimiters = {
" \ '>': { 'pattern': '>>\|=>\|->\|>' },
" \ }
" " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
xmap ga <Plug>(EasyAlign)

" tComment with <C-/>
nnoremap  :TComment<CR>
vnoremap  :TComment<CR>"

" Plug 'scrooloose/syntastic'
" let g:syntastic_ruby_checkers = ['rubocop', 'mri']
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_warning_symbol = '⚠'
" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1


autocmd! BufWritePost * Neomake
let g:neomake_shellcheck_args = ['-fgcc']

" Plug 'fatih/vim-go', { 'for': 'go', 'commit': '5573e9c' }
" Plug '~/code/personal/git/vim-go'
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>gc <Plug>(go-coverage)
au FileType go nmap <leader>gi <Plug>(go-install)
au FileType go nmap <leader>i <Plug>(go-info)
au FileType go nmap <leader>u <Plug>(go-callers)
" Use shift+F6 to match intellij
" au FileType go nmap <F18> <Plug>(go-rename)
au FileType go nmap <S-F6> <Plug>(go-rename)
au FileType go map ]l :lne<CR>
au FileType go map [l :lp<CR>
" let g:go_fmt_command = "goimports"
" Fixes the folds closed on save issue
" g:go_fmt_experimental = 1
" It doesn't let me see the errors
" let g:go_auto_type_info = 1
au BufRead,BufNewFile *.gtpl set filetype=gohtmltmpl
" let $PATH = $PATH . ':/home/david/go/bin:/home/david/general/code/go/bin'
let g:go_bin_path = '/home/david/go/bin'
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_metalinter_enabled = ['vet', 'golint']
" let g:go_metalinter_autosave_enabled = ['vet', 'golint']
" let g:syntastic_go_checkers = ['golint', 'vet']

" let g:tagbar_type_go = {
"     \ 'ctagstype' : 'go',
"     \ 'kinds'     : [
"         \ 'p:package',
"         \ 'i:imports:1',
"         \ 'c:constants',
"         \ 'v:variables',
"         \ 't:types',
"         \ 'n:interfaces',
"         \ 'w:fields',
"         \ 'e:embedded',
"         \ 'm:methods',
"         \ 'r:constructor',
"         \ 'f:functions'
"     \ ],
"     \ 'sro' : '.',
"     \ 'kind2scope' : {
"         \ 't' : 'ctype',
"         \ 'n' : 'ntype'
"     \ },
"     \ 'scope2kind' : {
"         \ 'ctype' : 't',
"         \ 'ntype' : 'n'
"     \ },
"     \ 'ctagsbin'  : 'gotags',
"     \ 'ctagsargs' : '-sort -silent'
"     \ }
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-easytags'

" Plug 'zxiest/vim-ruby', { 'for': 'ruby' }
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1




"Plug 'DavidGamba/vim-asciidoc', { 'for': 'asciidoc', 'branch': 'clean-arguments' }
"Plug '~/code/personal/git/vim-asciidoc', {'for': 'asciidoc' }
let vimple_init_vn = 0

let g:terraform_fmt_on_save=1
let g:terraform_align=1
" Plug 'juliosueiras/vim-terraform-completion', { 'for': ['terraform'] }

" All of your Plugins must be added before the following line

" https://github.com/neovim/neovim/issues/2127
" Neovim doesn't check file changes after focus is lost
autocmd BufEnter,FocusGained * checktime

" Autosave
autocmd TextChanged,TextChangedI,InsertLeave <buffer> silent write

" Write file on Make
set autowriteall

set background=light
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
                  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
                  \,sm:block-blinkwait175-blinkoff150-blinkon175
au VimLeave * set guicursor=a:block-blinkon0

set list                     " shows tabbed spaces
set listchars=tab:˲\ ,trail:·,extends:»,precedes:« " Unprintable chars mapping
" ▸ ˲ ˃ ˍ
set tabstop=2
" set expandtab
set shiftwidth=2
set softtabstop=2
set number
set ignorecase
set smartcase
set textwidth=0

set wrap
set linebreak " Visually break long lines at 'breakat' character
set whichwrap=b,s,<,>
set foldmethod=syntax
set foldnestmax=1

set clipboard+=unnamedplus

set undofile
set undodir=.
set backupdir=.
set inccommand=split

iab <expr> dts strftime("%c")

" Save with ,w
noremap <leader>w :update<CR>

" search/replace the word under the cursor
nnoremap <leader>z :let @z = expand("<cword>")<cr>q:i%s/\C\v<<esc>"zpa>//g<esc>hi

set tags=./tags;./.tags;,~/.vimtags,~/code/personal/git/gocode/src/gotags.ctags

" Paste using set paste
inoremap <leader>v <ESC>:set paste<CR>"*p:set nopaste<CR>

" Quickly get out of the closign paren
inoremap <C-l><C-l> <ESC>la

" Navigation {
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

  " Move around buffers
  nmap <C-J> <C-W><C-J>
  nmap <C-K> <C-W><C-K>
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

  nmap <m-b> :Buffers<CR>

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

imap ,* •

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

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of preview window when open
function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:Search
  endif
endfunction

" restore position in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

" Enter acts as C-y when there are drop down menu selections
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Find files without extention in their filename
set suffixesadd+=.pl,.pm,.text

set complete=.,w,b,u,t,i,kspell
set spellfile=~/vim-local-spell.utf-8.add

if exists('g:loaded_surround')
    " vim-surround: q for `foo' and Q for ``foo''
    let b:surround_{char2nr('q')} = "‘\r’"
    let b:surround_{char2nr('Q')} = "“\r”"
endif

au FileType go set listchars=tab:\ \ ,trail:·,extends:»,precedes:« " Unprintable chars mapping
autocmd FileType asciidoc :compiler asciidoctor | setlocal spell | setlocal textwidth=0 | inoremap <leader>u [.underline]#<ESC>ea#<ESC> | nnoremap <leader>u i[.underline]#<ESC>ea#<ESC>
au FileType groovy setlocal tabstop=4 | setlocal expandtab | setlocal shiftwidth=4 | setlocal softtabstop=4
au FileType puppet setlocal tabstop=2 | setlocal expandtab | setlocal shiftwidth=2 | setlocal softtabstop=2
au FileType python setlocal tabstop=4 | setlocal expandtab | setlocal shiftwidth=4 | setlocal softtabstop=4 | setlocal textwidth=80 | setlocal autoindent | setlocal fileformat=unix
au FileType yaml setlocal indentexpr&
call tcomment#type#Define('terraform', '# %s')

augroup textobj_quote
  autocmd!
  autocmd FileType asciidoc call textobj#quote#init({'educate': 1})
augroup END

autocmd BufWritePost *.go silent! normal zO
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
command! TemplatePerl read $HOME/dotrc/vim_templates/perl.pl
command! TemplateRuby read $HOME/dotrc/vim_templates/ruby.rb
command! TemplateScala read $HOME/dotrc/vim_templates/scala.scala
command! TemplateGo read $HOME/dotrc/vim_templates/go.go
