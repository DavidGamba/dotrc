" Basics {
    set nocompatible " explicitly get out of vi-compatible mode
    if has("gui")
        set guioptions-=T
    endif
    if &t_Co == 256 || has("gui_running")
        colorscheme xoria256
    else
        colorscheme desert
        set background=dark
    endif
    set title
    set titlestring=%F%m%r%h%w\ %y\ %(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
    set number
    set t_Co=256
    set visualbell t_vb= " no bell
    set timeoutlen=500
    " Syntax coloring lines that are too long just slows down the world
    set synmaxcol=100
    " set backup            " keep backups
    set ruler " show line and column number
    set showcmd           " Show (partial) command in status line.
    set loadplugins
    set path+=/usr/local/include
    set viminfo='50,\"50,h " keep 50 marks and 50 lines of registers
    set history=100
    set list " shows tabbed spaces
"}
" Text Formatting {
    " my perl includes pod
    let perl_include_pod = 1
    " syntax color complex things like @{${"foo"}}
    let perl_extended_vars = 1
    if has("syntax") && &t_Co > 2
        syntax on
    endif
    set ignorecase
    set smartcase
    set wildmode=longest:full,list
    set autowrite " write current file when changing buffers, e.g. :bn
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set backspace=indent,eol,start "make backspace more flexible
    set nostartofline
    set smarttab
    set autoindent
    set smartindent
    " autocmd filetype perl set smartindent
    " set cindent
    set nocopyindent
    " Indentation the way Emacs does it
    " set cinkeys=0{,0},:,0#,!<Tab>,!^F
    set textwidth=72
    set expandtab
    autocmd filetype make set noexpandtab
    autocmd filetype perl set textwidth=72
"}
" General {
    "set nohlsearch
    set incsearch
    set hlsearch
    highligh search cterm=underline ctermbg=0
    set showmatch " show matching brackets
    if has("cursorline")
        set cursorline
    endif
    set clipboard=unnamed " yanks everything to the * register
    "set go+=a " the Visual selection is automatically copied to the clipborad
    "set clipboard+=unnamed " share windows clipboard
    set wildmenu " turn on command line completion wild style
    set mouse=a "use mouse everywhere
    set mousemodel=popup
    set sidescroll=20
    set whichwrap=b,s,<,>
    set listchars=tab:>-,trail:- " fill tabs with >---
    "hi User1 term=underline cterm=bold ctermfg=Cyan ctermbg=Blue guifg=#40ffff guibg=#0000aa
    set statusline=%F%m%r%h%w\ type=%y\ ascii=\%03.3b\ hex=\%02.2B\ row\ %04l\/%L,col%04v\ %p%%\ \ \ F2=paste
    " paste mode - this will avoid unexpected effects when you
    " cut or copy some text from one window and paste it in Vim.
    set pastetoggle=<F2>
    set laststatus=2
"}
" Folding {
    function! CssFoldText()
        let line = getline(v:foldstart)
        let nnum = nextnonblank(v:foldstart + 1)
        while nnum < v:foldend+1
            let line = line . " " . substitute(getline(nnum), "^ *", "", "g")
            let nnum = nnum + 1
        endwhile
        return line
    endfunction

    setlocal foldtext=CssFoldText()
    setlocal foldmethod=marker
    setlocal foldmarker={,}
    setlocal fillchars=fold:/
    setlocal foldlevel=-1
"   highlight Folded term=underline cterm=bold gui=bold guifg=Blue guibg=Black
"   highlight FoldColumn term=underline cterm=bold gui=bold guifg=Blue guibg=Black
"}
" Map Tab as ESC {
" The Tab key is mapped to Escape. Press Shift-Tab to insert a Tab.
" To minimize Tab use, you can use '<', '>' and ':set autoindent'
nnoremap <silent> <Tab> <Esc>:nohlsearch<bar>pclose<CR>|
vnoremap <Tab> <Esc><Nul>| " <Nul> added to fix select mode problem
inoremap <Tab> <Esc>|
nnoremap <S-Tab> i<Tab><Esc><Right>
vnoremap <S-Tab> >gv|
inoremap <S-Tab> <Tab>|
"}
" Split mapping {
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
set wmh=1
map <C-H> :bn<Enter>
map <C-L> :bp<Enter>
" }
" Key Mapping {
" 'quote' a word
nnoremap qw :silent! normal mpea'<Esc>bi'<Esc>`pl
nnoremap qW :silent! normal mpEa'<Esc>Bi'<Esc>`pl
" double "quote" a word
nnoremap qd :silent! normal mpea"<Esc>bi"<Esc>`pl
nnoremap qD :silent! normal mpEa"<Esc>Bi"<Esc>`pl
" remove quotes from a word
"nnoremap wq :silent! normal mpeld bhd `ph<CR>

vnoremap <F9> "+y

inoremap (( ()<Left>
inoremap {{ {}<Left>
inoremap }} {<Enter>}<Esc><Up>o
inoremap [[ []<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap << <><Left>
"}
" Perl {
" check perl code with :make
autocmd filetype perl set makeprg=perl\ -c\ %\ $*
autocmd filetype perl set errorformat=%f:%l:%m
autocmd filetype perl set autowrite

" comment/uncomment blocks of code (in vmode)
vmap ,c :s/^/#/gi<Enter>
vmap ,C :s/^#//gi<Enter>

" Tidy selected lines (or entire file) with ,t:
nnoremap <silent> ,t :%!perltidy -q<Enter>
vnoremap <silent> ,t :!perltidy -q<Enter>
"}
