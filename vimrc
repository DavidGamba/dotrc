" Basics {
    set nocompatible " explicitly get out of vi-compatible mode

    set title
    set titlestring=%F%m%r%h%w\ %y\ %(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

    set number

    " No annoying sournd on errors
    set novisualbell
    set noerrorbells
    set t_vb= " no bell
    set tm=500

    set history=500
"}

" Colors and fonts {
    set t_Co=256
    if has("syntax")
        syntax on
    endif
    " Syntax coloring lines that are too long just slows down the world
    set synmaxcol=300

"   set background=dark
    if has("gui_running")
        colorscheme desert
        "colorscheme elflord
        set guioptions-=T
        set guioptions+=e
        set guitablabel=%M\ %t
    else
        colorscheme desert
    endif

    set encoding=utf8
    set fileencoding=utf8
"   set ffs=unix,dos,mac
" }

" General {
    " Enable filetype plugins
    filetype plugin on
    filetype indent on

    set loadplugins
    set path+=/usr/local/include
    set path+=lib

    " Set to auto read when a file is changed from the outside
    set autoread

    " With a map leader it's possible to do extra key combinations
    let mapleader = ","
    let g:mapleader = ","

    " Fast saving
    nmap <leader>w :w<cr>

    set showmatch " show matching brackets
    " How many tenths of a second to blink when matching brackets
    set mat=2

    if has("cursorline")
        set cursorline
    endif

    "set clipboard=unnamed " yanks everything to the * register PRIMARY clipboard
    set clipboard=unnamedplus " yanks everything to the * register CLIPBOARD clipboard
    "set go+=a " the Visual selection is automatically copied to the clipborad
    "set clipboard+=unnamed " share windows clipboard
    "
    set wildmenu " turn on command line completion wild style
    " set wildchar
    set wildmode=longest:full,list
    " Ignore compiled files
    set wildignore=*.o,*~,*.pyc

    set mouse=a "use mouse everywhere
"   set mousemodel=extend


    set backspace=indent,eol,start "make backspace more flexible

    set list " shows tabbed spaces
    set listchars=tab:>-,trail:- " fill tabs with >---

    "hi User1 term=underline cterm=bold ctermfg=Cyan ctermbg=Blue guifg=#40ffff guibg=#0000aa
    set laststatus=2 " Always show the status line
    set statusline=                              " clear the statusline for when vimrc is reloaded"
    set statusline+=%{HasPaste()}                " Check if pastemode is on
    set statusline+=%2*[%n%H%M%R%W]\             " flags and buf no
    set statusline+=%1*%y\                       " file type
    set statusline+=%*%F%r%h%w%1*\               " File name
    set statusline+=%1*[line\ %l\/%L,%v]\        " possition information
    set statusline+=%<\                          " cut
    set statusline+=%=                           " cut to right
    set statusline+=%*F2=paste\ F9=copy%1*\      " simple reminder text
    set statusline+=%{v:register}\               " current register
    set statusline+=%{&fileformat}               " file format
    " Sets the height of the command bar
    "set cmdheight=1
    set showcmd           " Show (partial) command in status line.
    set showmode          " Show current mode

    " paste mode - this will avoid unexpected effects when you
    " cut or copy some text from one window and paste it in Vim.
    set pastetoggle=<F2>

    " Don't redraw while executing macros (good performance config)
    set lazyredraw

"}

" Searching {
    "set nohlsearch
    set incsearch
    set hlsearch
    highligh search cterm=underline ctermbg=0
    set ignorecase "set ignore case when searching
    set smartcase " when searching try to be smart about cases
    " For regular expressions turn magic on
    set magic

    " Visual mode pressing * or # searches for the current selection
    " Super useful! From an idea by Michael Naumann
    vnoremap <silent> * :call VisualSelection('f')<CR>
    vnoremap <silent> # :call VisualSelection('b')<CR>
    function! VisualSelection(direction) range
        let l:saved_reg = @"
        execute "normal! vgvy"

        let l:pattern = escape(@", '\\/.*$^~[]')
        let l:pattern = substitute(l:pattern, "\n$", "", "")

        if a:direction == 'b'
            execute "normal ?" . l:pattern . "^M"
        elseif a:direction == 'gv'
            call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
        elseif a:direction == 'replace'
            call CmdLine("%s" . '/'. l:pattern . '/')
        elseif a:direction == 'f'
            execute "normal /" . l:pattern . "^M"
        endif

        let @/ = l:pattern
        let @" = l:saved_reg
    endfunction

    " Map <Space> to / (search)
    map <space> /
" }

" Saving, backups and undo {
    " set backup " keep backups
    set nobackup
    set nowb " No backup before overwriting
    set autowrite " write current file when changing buffers, e.g. :bn

    set undofile
    set undodir=.
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

" Text Formatting {
    set expandtab " spaces instead of tabs
    autocmd filetype make set noexpandtab " except for makefiles
    set smarttab
    " 1 tab = 4 spaces
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4

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

    set textwidth=72
    autocmd filetype perl set textwidth=80
    autocmd filetype text set textwidth=80
    autocmd filetype mail set textwidth=72
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
"    nnoremap <silent> <Tab> <Esc>:nohlsearch<bar>pclose<CR>|
"    vnoremap <Tab> <Esc><Nul>| " <Nul> added to fix select mode problem
"    inoremap <Tab> <Esc>|
"    nnoremap <S-Tab> i<Tab><Esc><Right>
"    vnoremap <S-Tab> >gv|
"    inoremap <S-Tab> <Tab>|
"}

" Enable Alt mappings on terminals that generate a .. z {
" It is better to create a mapping for each alt-mapping individualy not
" to block the Alt escaping functionality. Keeping code as reference
"    let c='a'
"    while c <= 'z'
"      exec "set <A-".c.">=\e".c
"      exec "imap \e".c." <A-".c.">"
"      let c = nr2char(1+char2nr(c))
"    endw
"    set timeoutlen=800 " Time to wait as a timeout
    set timeout ttimeoutlen=50
" }


" Moving around {

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
    if has("mac") || has("macunix")
        nmap <D-j> <M-J>
        nmap <D-k> <M-K>
        vmap <D-j> <M-J>
        vmap <D-k> <M-K>
    endif

    exec "set <A-i>=\ei"
    imap <M-i> <ESC>I
    exec "set <A-a>=\ea"
    imap <M-a> <ESC>A
" }

" Buffers and tabs {
    " use open tab when switching the buffer
    set switchbuf=useopen,usetab,newtab
    set showtabline

    set winminheight=1
    set winminwidth=1

    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    nmap `h <C-W>h500<C-W>>
    nmap `l <C-W>l500<C-W>>

    map <C-H> :bn<CR>
    map <C-L> :bp<CR>
"    map <C-H> :tabprevious<CR>
"    map <C-L> :tabnext<CR>
    command! -nargs=* -complete=file T tabnew <args>
    command! TC :tab split

    " Return to last edit position when opening files (You want this!)
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
    " Remember info about open buffers on close
"   set viminfo='50,\"50,h " keep 50 marks and 50 lines of registers
    set viminfo^=%
" }

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
"map <leader>q :e ~/buffer<cr>

" Key Mapping {
    " 'quote' a word
    nnoremap \w :silent! normal mpea'<Esc>bi'<Esc>`pl
    nnoremap \W :silent! normal mpEa'<Esc>Bi'<Esc>`pl
    " Visual selection gets surrounded by quotes
    vnoremap \w s''<Esc>hpll

    " double "quote" a word
    nnoremap \d :silent! normal mpea"<Esc>bi"<Esc>`pl
    nnoremap \D :silent! normal mpEa"<Esc>Bi"<Esc>`pl
    " Visual selection gets surrounded by double quotes
    vnoremap \d s""<Esc>hpll
    " remove quotes from a word
    "nnoremap wq :silent! normal mpeld bhd `ph<CR>

    vnoremap <F9> "+y

" Use delimitMate plugin to close matching pairs {
    " http://www.vim.org/scripts/script.php?script_id=2754
    "let loaded_delimitMate = 1 " if set prevents delimitMate from loading.
    let delimitMate_balance_matchpairs = 1
    let delimitMate_expand_cr = 1
    let delimitMate_expand_space = 1
    let delimitMate_matchpairs = "(:),[:],{:},`:`"
    " Latex quotes start with ` and end with '
    au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:}"
    au FileType tex inoremap ` `'<left>
    au FileType tex inoremap `` ``''<left><left>
"}

" I am not fully happy with delimitMate expand_cr so...
inoremap }} {<Enter>}<Esc><Up>o
inoremap )) (<Enter>)<Esc><Up>o<Tab>
" Visual selection gets surrounded by a block
vnoremap \{ s{<CR>}<Esc>kp=iB
" Visual selection gets surrounded by a block
vnoremap \( s(<CR>)<Esc>kp=iB

noremap ct-- ct_

" reverse lines
command! -bar -range=% Reverse <line1>,<line2>g/^/m<line1>-1
command! -bar -range=% Rev <line1>,<line2>g/^/m<line1>-1
"}

" Programming Languages {
    "include pod.vim syntax file with perl.vim"
    let perl_include_pod   = 1
    "highlight complex expressions such as @{[$x, $y]}"
    let perl_extended_vars = 1
    "use more context for highlighting"
    let perl_sync_dist     = 250

    " check perl code with :make
    au filetype perl set makeprg=perl\ -c\ %\ $*
    au filetype perl set errorformat=%f:%l:%m
    au filetype perl set autowrite

    " Tidy selected lines (or entire file) with ,t:
    au filetype perl nnoremap <silent> ,t :%!perltidy -q<Enter>
    au filetype perl vnoremap <silent> ,t :!perltidy -q<Enter>

    " Make pod word bold B<<>>
    au filetype perl nnoremap <leader>b BiB<< <Esc>Ea >><Esc>
    au filetype perl vnoremap <leader>b s//B<< >>/ <Esc>hpll
    au filetype html,ruby set tabstop=2 | set shiftwidth=2 | set softtabstop=2
"}

" Comment/Uncomment lines {
    " comment/uncomment blocks of code (in vmode)
    au filetype * vmap <leader>c :s/^/#/gi<Enter>:nohlsearch<CR>
    au filetype * vmap <leader>C :s/^#//gi<Enter>:nohlsearch<CR>

    " comment/uncomment blocks of text for mail messages (in vmode)
    au filetype mail vmap <leader>c :s/^/> /gi<Enter>:nohlsearch<CR>
    au filetype mail vmap <leader>C :s/^> //gi<Enter>:nohlsearch<CR>

    " comment/uncomment blocks of text for vim (in vmode)
    au filetype vim vmap <leader>c :s/^/\"/gi<Enter>:nohlsearch<CR>
    au filetype vim vmap <leader>C :s/^\"//gi<Enter>:nohlsearch<CR>

    " comment/uncomment blocks of text for latex (in vmode)
    au filetype tex,plaintex vmap <leader>c :s/^/\%/gi<Enter>:nohlsearch<CR>
    au filetype tex,plaintex vmap <leader>C :s/^%//gi<Enter>:nohlsearch<CR>
"}

" Open link in web browser {
    function! Browser ()
      let line = expand("<cWORD>")
      exec ":silent !firefox ".line
    endfunction
    map \f :call Browser ()<CR>:redraw!<CR>
" }

" Tags {
    let Tlist_Use_Right_Window = 1
    set tags=tags.ctags;/.
" }
"

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

" Reload vim on change
" watches for the many variations of Vim config filenames so that it's
" compatible with GUI Vim, Windows Vim, etc.
"augroup myvimrc
"    au!
"    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
"augroup END

"CDC = Change to Directory of Current file
command! CDC cd %:p:h
command! Perl read $HOME/dotrc/vim_templates/perl.pl
command! Asciidoc read $HOME/dotrc/vim_templates/asciidoc.asciidoc
" % gives the name of the current file, %:p gives its full path, and
" %:p:h gives its directory (the 'head' of the full path). )

"Reload vimrc file
command! RC so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif

" HasPaste (Returns true if paste mode is enabled) {
function! HasPaste()
    if &paste
        return 'PASTE MODE (F2) '
    endif
    return ''
endfunction
" }
"
if filereadable($HOME . "/local/vimrc_local")
    source $HOME/local/vimrc_local
endif
