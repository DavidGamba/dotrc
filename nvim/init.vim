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

Plug 'christoomey/vim-tmux-navigator'

"""""""""""""""""""""""""""""""""""""""
" Completion
"""""""""""""""""""""""""""""""""""""""
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/echodoc.vim'
Plug 'neomake/neomake'

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

"""""""""""""""""""""""""""""""""""""""
" Styling
"""""""""""""""""""""""""""""""""""""""
Plug 'vim-airline/vim-airline'

" Use treesitter highlights
Plug 'nvim-treesitter/nvim-treesitter'

" Add a line of context showing the function when you scroll
" Plug 'romgrk/nvim-treesitter-context'

" Tagbar like symbol view | Not in use because gopls doesn't support symbols yet.
" Plug 'liuchengxu/vista.vim'

" :SemanticHighlightToggle
Plug 'jaxbot/semantic-highlight.vim'

Plug 'wfxr/minimap.vim'


" colorscheme
Plug 'NLKNguyen/papercolor-theme'
" Plug 'Iron-E/nvim-highlite'
Plug 'morhetz/gruvbox'
" Plug 'sainnhe/gruvbox-material'

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

Plug 'bfredl/nvim-miniyank'

" <leader>sf
Plug 'obreitwi/vim-sort-folds'

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

Plug 'wincent/corpus'

" Git support
Plug 'tpope/vim-fugitive'

"""""""""""""""""""""""""""""""""""""""
" Language support
"""""""""""""""""""""""""""""""""""""""
Plug 'hashivim/vim-terraform', { 'for': ['terraform'] }
Plug 'suoto/vim-antlr', { 'for': ['antlr4'] }
Plug 'sebdah/vim-delve', { 'for': ['go'] }

" All of your Plugins must be added before the following line
call plug#end()            " required
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
" Core
"""""""""""""""""""""""""""""""""""""""

" Map ; to : to avoid having to use the shift key
nnoremap ; :

command! Config execute ":e $MYVIMRC"
command! Reload execute "source $MYVIMRC"

function! ReloadLSP()
	lua vim.lsp.stop_client(vim.lsp.get_active_clients())
	:edit
endfunction
command! ReloadLSP call ReloadLSP()

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

set undofile
set backupdir=.
set inccommand=split

" autochdir conflicts with dirvish
" https://github.com/justinmk/vim-dirvish/issues/19
set noautochdir
augroup auto_ch_dir
	autocmd!
	autocmd BufEnter * silent! lcd %:p:h
augroup END

set diffopt=internal,filler,closeoff,algorithm:minimal

"""""""""""""""""""""""""""""""""""""""
" Completion
"""""""""""""""""""""""""""""""""""""""
set wildoptions=pum
"set complete=.,w,b,u,t,i,kspell

" neocomplete like
" set completeopt+=noinsert
" deoplete.nvim recommend
" set completeopt+=noselect

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" call deoplete#custom#source('LanguageClient', 'max_menu_width', 150)
" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
if !exists("g:UltiSnipsSnippetDirectories")
  let g:UltiSnipsSnippetDirectories = [$HOME ."/dotrc/vim-snippets"]
else
  let g:UltiSnipsSnippetDirectories += [$HOME ."/dotrc/vim-snippets"]
endif

set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'
" let g:echodoc#type = 'virtual'

autocmd! BufWritePost * Neomake
let g:neomake_shellcheck_args = ['-fgcc']

nnoremap <F2> :%s/<C-R>///g<left><left>

" TODO:
" " Rename - rc => rename camelCase
" noremap <leader>rc :call LanguageClient#textDocument_rename(
" 						\ {'newName': Abolish.camelcase(expand('<cword>'))})<CR>
"
" " Rename - rs => rename snake_case
" noremap <leader>rs :call LanguageClient#textDocument_rename(
" 	\ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>
"
" " Rename - ru => rename UPPERCASE
" noremap <leader>ru :call LanguageClient#textDocument_rename(
" 	\ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>


" https://github.com/neovim/nvim-lsp#gopls
" https://github.com/golang/tools/blob/master/gopls/doc/vim.md
" https://www.reddit.com/r/neovim/comments/h0ndj0/to_those_who_have_integrated_lsp_functionality/
lua << EOF
	local lspconfig = require'lspconfig'

	local on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
		-- require'completion'.on_attach()

		-- Mappings.
		local opts = { noremap=true, silent=true }

		-- go Declaration
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
		-- go definition
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
		-- Not implemented in gopls
		-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.peek_definition()<CR>', opts)

		-- go hover
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

		-- go list imlementation
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gli', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

		-- go signature
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

		-- go to type
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'glt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

		-- Rename with same keymapping as vscode
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

		-- go references
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

		-- go line diagnostic
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gld', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)

		vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

		-- go action
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
		-- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>a', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>a', ':lua vim.lsp.buf.range_code_action()<CR>', opts)

		vim.api.nvim_buf_set_keymap(bufnr, 'n', '=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

		-- go calls incoming
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)

		-- go calls outgoing
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gco', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)

		-- go workspace
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)

		-- go Workspace
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)

		-- Set autocommands conditional on server_capabilities
		if client.resolved_capabilities.document_highlight then
			vim.api.nvim_exec([[
				hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
				hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
				hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
				augroup lsp_document_highlight
					autocmd! * <buffer>
					autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
					autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
				augroup END
			]], false)
		end

	end

	-- custom client capabilities: https://gist.github.com/PatOConnor43/88156409b03794f5e05280dbfb42faa6

	lspconfig.gopls.setup {
		on_attach = on_attach,
		-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
		settings = {
			gopls = {
				analyses = {
					-- unusedparams = true,
					unreachable = true,
				},
				staticcheck = true,
				-- usePlaceholders = true,
				-- hoverKind = "SingleLine", -- "FullDocumentation" seems broken
				-- linksInHover = false,
				-- experimentalWorkspaceModule  = false,
			},
		},
	}

require'nvim-treesitter.configs'.setup {
	highlight             = {
		enable = true,
		additional_vim_regex_highlighting = true, -- fixes spell check on comments only
	},
	indent                = { enable = true },
	incremental_selection = { enable = true },
	textobjects           = { enable = true },
}

EOF

"""""" nvim-lua/completion-nvim
autocmd BufEnter * lua require'completion'.on_attach()

let g:completion_enable_snippet = 'UltiSnips'
let g:completion_enable_fuzzy_match = 1
let g:completion_matching_ignore_case = 1
" possible value: "length", "alphabet", "none"
let g:completion_sorting = "none"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing extra message when using completion
set shortmess+=c
""""""

let g:fzf_layout = { 'up': '~40%' }
nmap <C-p> :Files<CR>
" search
nmap <leader>s :Rg<space>


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

" Folding setup
" set foldmethod=syntax
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldnestmax=3
set nofoldenable

set ignorecase
set smartcase

let g:gruvbox_italic=1
let g:gruvbox_contrast_light="hard"
" colorscheme gruvbox

let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_palette = 'original'
" colorscheme gruvbox-material

" colorscheme highlite

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'allow_bold': 1,
  \       'allow_italic': 1
  \     }
  \   }
  \ }
colorscheme PaperColor

let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'conflicts' ]
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_c = '%F'

" Keep cursor in place after yank
" https://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"
vnoremap Y myY`y

"""""""""""""""""""""""""""""""""""""""
" Spell and highlights
"""""""""""""""""""""""""""""""""""""""
set spell spelllang=en_ca
hi clear SpellBad
hi SpellBad term=undercurl cterm=undercurl gui=undercurl guisp=Red
"set spellfile=~/vim-local-spell.utf-8.add

"""""""""""""""""""""""""""""""""""""""
" bfredl/nvim-miniyank
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>n <Plug>(miniyank-cycle)
map <leader>N <Plug>(miniyank-cycleback)
"""""""""""""""""""""""""""""""""""""""

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
" Mnemonic go buffers
nnoremap gb :Buffers<CR>

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

" markdown.corpus breaks ultisnips
autocmd BufNewFile,BufRead *.md set syntax=markdown

lua << EOF
CorpusDirectories = {
	['~/work/notes/'] = {
		autocommit = false,
		autoreference = true,
		autotitle = true,
		base = './',
		transform = 'web',
		tags = {'work'},
	},
	['~/general/projects/notes/'] = {
		autocommit = false,
		autoreference = true,
		autotitle = true,
		base = './',
		transform = 'web',
		tags = {'personal'},
	},
}
EOF

