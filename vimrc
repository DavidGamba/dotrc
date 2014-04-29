" Basics {
  set nocompatible               " be iMproved
  filetype off                   " required by Vundle!
  filetype plugin indent on      " Automatically detect file types.
  syntax on                      " enable syntax
  set modeline                   " Enable footer of the type '# vim: set filetype=vim'
  set background=dark
  set t_Co=256
  colorscheme desert
  hi Search ctermfg=160 ctermbg=232 cterm=Bold
  if &diff
    colorscheme desert
  endif
  set timeoutlen=250 " Time to wait after ESC (default causes an annoying delay)
  set synmaxcol=300  " Syntax coloring lines that are too long just slows down the world
  set lazyredraw     " Don't redraw while executing macros (good performance config)
  set noerrorbells visualbell t_vb= " No annoying sournd on errors
  if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
  endif
  set guioptions-=m "remove menu bar
  set guioptions-=T "remove toolbar
  set guioptions-=r "remove right-hand scroll bar
  set history=256
  set number
  set encoding=utf8
  set fileencoding=utf8
  set autoread  " Set to auto read when a file is changed from the outside
  set autowrite " write current file when changing buffers, e.g. :bn
  "set clipboard=unnamed " yanks everything to the * register PRIMARY clipboard
  set clipboard=unnamedplus " yanks everything to the * register CLIPBOARD clipboard
  set mouse=a "use mouse everywhere
  set mousehide  " Hide mouse after chars typed

  let g:mapleader = ","

  set list                     " shows tabbed spaces
  " set listchars=tab:>-,trail:- " fill tabs with >---
  set listchars=tab:▸\ ,trail:·,extends:»,precedes:« " Unprintable chars mapping
  set showmatch " show matching brackets
  set mat=2     " How many tenths of a second to blink when matching brackets
  set incsearch
  set hlsearch
  set ignorecase "set ignore case when searching
  set smartcase  " when searching try to be smart about cases
  set magic " For regular expressions turn magic on
  set path+=/usr/local/include
  set path+=lib
  if filereadable($HOME . "/local/vimrc_local")
    source $HOME/local/vimrc_local
  endif
  set nobackup
  set nowb " No backup before overwriting
  if exists("+undofile")
    set undofile
    set undodir=.
  endif
  set viminfo^=
  set tags=tags.ctags;/.
"}

" Text Formatting {
  set backspace=indent,eol,start "make backspace more flexible

  " 1 tab = 2 spaces
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2

  set expandtab                         " spaces instead of tabs
  autocmd filetype make set noexpandtab " except for makefiles

  set smarttab

  set nostartofline
  set autoindent
  set smartindent
  " set cindent
  set nocopyindent
  " Indentation the way Emacs does it
  " set cinkeys=0{,0},:,0#,!<Tab>,!^F

  set linebreak " Linebreak

  set sidescroll=20 " The minimal number of columns to scroll horizontally if wrap=off
  set whichwrap=b,s,<,>
  set wrap
  set textwidth=0
  set wildmenu " turn on command line completion wild style
  " set wildchar
  "set wildmode=longest:full,list
  set wildmode=longest,full,list
  " Ignore compiled files
  set wildignore=*.o,*.*~,*.pyc
  " Enter acts as C-y when there are drop down menu selections
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

  " Remove the Windows ^M - when the encodings gets messed up
  noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
  " Bind F5 to remove trailing spaces. http://vim.wikia.com/wiki/Remove_unwanted_spaces
  nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
"}

" Navigation {
  " Make navigation more amenable to the long wrapping lines.
  noremap k gk
  noremap j gj
  noremap <buffer> <Up> gk
  noremap <buffer> <Down> gj
  noremap <buffer> 0 g0
  noremap <buffer> ^ g^
  noremap <buffer> $ g$
  noremap <buffer> D dg$
  noremap <buffer> C cg$
  noremap <buffer> A g$a

  inoremap <buffer> <Up> <C-O>gk
  inoremap <buffer> <Down> <C-O>gj

  nmap <UP> <C-Y>
  nmap <DOWN> <C-E>

  " Move a line of text using `+[jk] or Comamnd+[jk] on mac
  nnoremap `j mz:m+<cr>`z
  nnoremap `k mz:m-2<cr>`z
  vnoremap `j :m'>+<cr>`<my`>mzgv`yo`z
  vnoremap `k :m'<-2<cr>`>my`<mzgv`yo`z

  " yy copies a line, use Y for y$
  nnoremap Y y$

  " no more : for ex commands
  nnoremap ; :

  exec "set <A-i>=\ei"
  imap <M-i> <ESC>I
  exec "set <A-a>=\ea"
  imap <M-a> <ESC><RIGHT>a

  " use open tab when switching the buffer
  set switchbuf=useopen,usetab,newtab
  set showtabline=1

  set winminheight=1
  set winminwidth=1

  map <C-J> <C-W><C-J>
  map <C-K> <C-W><C-K>
  map <C-L> <C-W><C-L>
  map <C-H> <C-W><C-H>
  " map <C-J> <C-W>j<C-W>_
  " map <C-K> <C-W>k<C-W>_
  " map <C-H> :bn<CR>
  " map <C-L> :bp<CR>
  nmap `h <C-W>h500<C-W>>
  nmap `l <C-W>l500<C-W>>


  command! -bar -range=% Reverse <line1>,<line2>g/^/m<line1>-1
  command! -bar -range=% Rev <line1>,<line2>g/^/m<line1>-1
" }

" Command and Auto commands {
" Sudo write
  comm! W exec 'w !sudo tee % > /dev/null' | e!
  noremap <leader>w :update<CR>
  " Save with C-S
  noremap <silent> <C-S>          :update<CR>
  vnoremap <silent> <C-S>         <C-C>:update<CR>
  inoremap <silent> <C-S>         <C-O>:update<CR>

  inoremap <silent> <C-Z>         <C-O>:update<CR><C-C><C-Z>

  " Keep visual selection after indentation in visual mode
  vmap < <gv
  vmap > >gv

  "Auto commands
  au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}     set ft=ruby
  au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                         set ft=markdown
  au BufRead,BufNewFile {COMMIT_EDITMSG}                                set ft=gitcommit
  au BufRead,BufNewFile {*.adoc,*.asciidoc,*.txt}                       set ft=asciidoc | set textwidth=80

  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif " restore position in file
" }

" Saving, backups and undo {
    if has('persistent_undo')
        command! DeleteUndoFile :call Delete_undo_file()
        command! Q :call Delete_undo_file() | :quit
    endif
    function! Delete_undo_file()
        :call delete(undofile(expand("%")))
        echohl WarningMsg
        echo "Undofile " . undofile(expand("%")) . " deleted!"
        echohl Normal
    endfunction
"}
"
" Spell Check {
    let g:myLang=0
    let g:myLangList=["nospell","en_us"]
    function! ToggleSpell()
        let g:myLang=g:myLang+1
        if g:myLang>=len(g:myLangList)
            let g:myLang=0
        endif
        if g:myLang==0
            setlocal nospell
        else
            execute "setlocal spell spelllang=".get(g:myLangList, g:myLang)
        endif
        echo "spell checking language:" g:myLangList[g:myLang]
    endfunction

    nmap <silent> <F7> :call ToggleSpell()<CR>
"}
"

" Programming Languages {
    " check perl code with :make
    au filetype perl setlocal makeprg=perl\ -c\ %\ $*
    au filetype perl setlocal errorformat=%f:%l:%m
    au filetype perl setlocal autowrite
    au filetype perl setlocal keywordprg=perldoc\ -f

    " Tidy selected lines (or entire file) with ,t:
    au filetype perl nnoremap <silent> ,t :%!perltidy -q<Enter>
    au filetype perl vnoremap <silent> ,t :!perltidy -q<Enter>

    " Make pod word bold B<<>>
    au filetype perl nnoremap <leader>b BiB<< <Esc>Ea >><Esc>
    au filetype perl vnoremap <leader>b s//B<< >>/ <Esc>hpll

    au filetype sh,bash setlocal keywordprg=help
"}

" Open link in web browser {
    function! Browser ()
      let line = expand("<cWORD>")
      exec ":silent !firefox ".line
    endfunction
    map \f :call Browser ()<CR>:redraw!<CR>
" }

" Buffer delete {
    nmap <leader>D BufferDelete()
    nmap <leader>d :bp<bar>sp<bar>bn<bar>bd<CR>
    function! BufferDelete()
        if &modified
            echohl ErrorMsg
            echomsg "No write since last change. Not closing buffer."
            echohl NONE
        else
            let s:total_nr_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))

            if s:total_nr_buffers == 1
                bdelete
                echo "Buffer deleted. Created new buffer."
            else
                bprevious
                bdelete #
                echo "Buffer deleted."
            endif
        endif
    endfunction
"}

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

"CDC = Change to Directory of Current file
command! CDC cd %:p:h
command! Perl read $HOME/dotrc/vim_templates/perl.pl
"Reload vimrc file
command! RC so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif

" ===============================================

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:

" Programming
Bundle "jQuery"
Bundle "rails.vim"
Bundle 'vim-ruby/vim-ruby'
Bundle 'scrooloose/syntastic'

" Command-T
Bundle "git://git.wincent.com/command-t.git"
let g:CommandTMatchWindowAtTop=1 " show window at top

" Utility
Bundle "surround.vim"
"Bundle "autoclose.vim" http://www.vim.org/scripts/script.php?script_id=1849
Bundle 'Townk/vim-autoclose'

" Navigation
Bundle "http://github.com/gmarik/vim-visual-star-search.git"

" tComment
Bundle "tComment"
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>"
nnoremap ,c :TComment<CR>
vnoremap ,c :TComment<CR>"

" Status line
Bundle "t9md/vim-ezbar"
set laststatus=2 " Always show the status line
let g:ezbar_enable = 1

