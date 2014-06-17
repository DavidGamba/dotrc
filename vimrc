set nocompatible               " be iMproved
filetype off                   " required by Vundle!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

" Sane defaults
Plugin 'tpope/vim-sensible'

" Coloring
Plugin 'kien/rainbow_parentheses.vim'
let g:rbpt_max = 8
au VimEnter * RainbowParenthesesActivate
au BufRead,BufNewFile * RainbowParenthesesLoadRound
au BufRead,BufNewFile * RainbowParenthesesLoadSquare
au BufRead,BufNewFile * RainbowParenthesesLoadBraces

Plugin 'tomasr/molokai'
let g:rehash256 = 1

" <leader>ig
Plugin 'nathanaelkane/vim-indent-guides'

" Status line
Plugin 'bling/vim-airline'
let g:airline#extensions#tabline#enabled = 1
" Plugin 't9md/vim-ezbar'
" let g:ezbar_enable = 1

" Navigation
Plugin 'thinca/vim-visualstar'

Plugin 'scrooloose/nerdtree.git'
" close VIM if NERDTree is the only buffer left
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

Plugin 'yegappan/mru'
Plugin 'wincent/Command-T.git'
let g:CommandTMatchWindowAtTop=1 " show window at top

" Utility
Plugin 'chilicuil/conque'
command! SH :ConqueTermSplit bash

Plugin 'maxbrunsfeld/vim-yankstack'
exec "set <A-p>=\ep"
exec "set <A-P>=\eP"

Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'Townk/vim-autoclose'

" Provides MixedCase (crm), camelCase (crc), snake_case (crs), and UPPER_CASE (cru)
Plugin 'tpope/vim-abolish.git'

" tComment
Plugin 'tomtom/tcomment_vim'
nnoremap ,c :TComment<CR>
vnoremap ,c :TComment<CR>"

" Moving around
Plugin 'Lokaltog/vim-easymotion'
" n-character search motion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n n:call HLNext(1)<cr>
map  N N:call HLNext(1)<cr>

function! HLNext (blinktime)
    set invcursorline
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 100) . 'm'
    set invcursorline
    redraw
endfunction

" Programming
Plugin 'jQuery'
Plugin 'rails.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'derekwyatt/vim-scala'

Plugin 'scrooloose/syntastic'
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" provides ++
Plugin 'nixon/vim-vmath'
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

Plugin 'Shougo/neocomplete'
let g:neocomplete#enable_at_startup = 1
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on                      " enable syntax
" ===============================================

" Basics {
  set modeline                   " Enable footer of the type '# vim: set filetype=vim'
  set background=dark
  set t_Co=256
  colorscheme twilight-term256
  " search highlight color
  hi Search ctermfg=160 ctermbg=232 cterm=Bold

  if &diff
    colorscheme desert
  endif
  set synmaxcol=300  " Syntax coloring lines that are too long just slows down the world
  set lazyredraw     " Don't redraw while executing macros (good performance config)
  set noerrorbells visualbell t_vb= " No annoying sournd on errors
  if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
  endif
  set guioptions-=m "remove menu bar
  set guioptions-=T "remove toolbar
  set guioptions-=r "remove right-hand scroll bar
  set number
  set fileencoding=utf8
  set autowrite " write current file when changing buffers, e.g. :bn
  "set clipboard=unnamed " yanks everything to the * register PRIMARY clipboard
  set clipboard=unnamedplus " yanks everything to the * register CLIPBOARD clipboard
  set mouse=a "use mouse everywhere
  set mousehide  " Hide mouse after chars typed

  let g:mapleader = ","

  set list                     " shows tabbed spaces
  set listchars=tab:▸\ ,trail:·,extends:»,precedes:« " Unprintable chars mapping
  set showmatch " show matching brackets
  " set mat=2     " How many tenths of a second to blink when matching brackets
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

  " 1 tab = 2 spaces
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2

  set expandtab                         " spaces instead of tabs
  autocmd filetype make set noexpandtab " except for makefiles

  set nostartofline
  set smartindent
  " set cindent
  set nocopyindent
  " Indentation the way Emacs does it
  " set cinkeys=0{,0},:,0#,!<Tab>,!^F

  set linebreak " Linebreak

  set whichwrap=b,s,<,>
  set wrap
  set textwidth=0
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

" search/replace the word under the cursor
nnoremap <leader>z :let @z = expand("<cword>")<cr>q:i%s/\C\v<<esc>"zpa>//g<esc>hi
" quickly edit vimrc
nnoremap <leader>e :e $MYVIMRC<cr>
" quickly reload vimrc
nnoremap <leader>r :source $MYVIMRC<cr>:e<cr>
" command! RC so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif

" Paste using set paste
inoremap <leader>v <ESC>:set paste<CR>"*p:set nopaste<CR>

" Quickly get out of the closign paren
inoremap <C-l><C-l> <ESC>la

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
  set showtabline=2

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
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif " restore position in file

  au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}     set ft=ruby
  au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                         set ft=markdown
  au BufRead,BufNewFile {COMMIT_EDITMSG}                                set ft=gitcommit
  au BufRead,BufNewFile {*.adoc,*.asciidoc,*.txt}                       set ft=asciidoc | set synmaxcol=3000

  au filetype yaml set tabstop=3 | set shiftwidth=3 | set softtabstop=3

  au filetype scala setl formatprg=$HOME/code/scala/scalariform.jar\ --stdin\ --stdout\ --preferenceFile=$HOME/code/scala/scalariform.properties

  " check perl code with :make
  au filetype perl setlocal makeprg=perl\ -c\ %\ $*
  au filetype perl setlocal errorformat=%f:%l:%m
  au filetype perl setlocal keywordprg=podbrowser
  au filetype perl setlocal formatprg=perltidy\ -q

  au filetype sh,bash setlocal keywordprg=help
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

" Disable search highlight after x seconds {
augroup NoHLSearch
  au!
  autocmd CursorHold,CursorMoved * call <SID>NoHLAfter(4)
augroup END

function! s:NoHLAfter(n)
  if !exists('g:nohl_starttime')
    let g:nohl_starttime = localtime()
  else
    if v:hlsearch && (localtime() - g:nohl_starttime) >= a:n
      :nohlsearch
      redraw
      unlet g:nohl_starttime
    endif
  endif
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
command! Ruby read $HOME/dotrc/vim_templates/ruby.rb
command! Scala read $HOME/dotrc/vim_templates/scala.scala
"Reload vimrc file
command! RC so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
