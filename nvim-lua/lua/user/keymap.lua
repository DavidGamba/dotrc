vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- keymap function
-- Modes:
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
local map = function(mode, key, result)
	vim.keymap.set(mode, key, result, {
		noremap = true,
		silent = true,
	})
end

map('n', ';', ':')
map('n', '<C-s>', ':w<CR>')
-- vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = false, })

-- CD to current path
map('n', '<leader>cd', ':cd %:p:h<CR>')
-- Copy current path
map('n', 'cp', ':let @+ = expand("%")<CR>')

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

-- map("v", "p", '"_dP') -- hold on to copied text for next paste operation

-- navigation
-- qwerty
-- map('n', 'k', 'gk')
-- map('n', 'j', 'gj')

local colemak = function()

	-- lets edit for insert
	map('n', 'l', 'i')
	map('v', 'l', 'i')
	--map('n','L', 'I')
	--map('v','L', 'I')
	--map('n','I', '<nop>')
	--map('v','I', '<nop>')

	-- motion
	map('n', 'i', 'l')
	map('v', 'i', 'l')
	map('n', 'n', 'j')
	map('v', 'n', 'j')
	map('n', 'e', 'k')
	map('v', 'e', 'k')

	-- next/prev
	map('n', 'k', 'n')
	map('n', 'K', 'N')

	-- end of word
	map('n', 'j', 'e')
	map('v', 'j', 'e')

	-- Move around splits
	map('n', '<C-N>', ':wincmd j<CR>')
	map('n', '<C-E>', ':wincmd k<CR>')
	map('n', '<C-H>', ':wincmd h<CR>')
	map('n', '<C-I>', ':wincmd l<CR>')
end
--colemak()

local qwerty = function()
	-- Move visually selected text up and down
	map("x", "J", ":move '>+1<CR>gv-gv")
	map("x", "K", ":move '<-2<CR>gv-gv")

	-- Navigate buffers
	map("n", "LL", ":bnext<CR>")
	map("n", "HH", ":bprevious<CR>")

	-- Move around splits
	map('n', '<C-J>', ':wincmd j<CR>')
	map('n', '<C-K>', ':wincmd k<CR>')
	map('n', '<C-H>', ':wincmd h<CR>')
	map('n', '<C-L>', ':wincmd l<CR>')
end
qwerty()

local kakoune = function()
	map('n', 'w', '<esc>ve')
end
--kakoune()

-- Keep visual selection after indentation in visual mode
map('v', '<', '<gv')
map('v', '>', '>gv')

map('n', 'gD', vim.lsp.buf.declaration) -- go Declaration
map('n', 'gd', vim.lsp.buf.definition) -- go definition
map('n', '<C-]>', vim.lsp.buf.definition)
map('n', 'K', vim.lsp.buf.hover)
-- Not implemented in gopls
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.peek_definition()<CR>', opts)

map('n', 'gh', vim.lsp.buf.hover) -- go hover

map('n', 'gli', vim.lsp.buf.implementation) -- go list imlementation

map('n', 'gH', vim.lsp.buf.signature_help) -- go signature

map('n', 'glt', vim.lsp.buf.type_definition) -- go list type

map('n', '<F2>', vim.lsp.buf.rename) -- Rename with same keymapping as vscode

map('n', 'glr', vim.lsp.buf.references) -- go list references

map('n', 'gld', vim.diagnostic.setloclist) -- go list diagnostic
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<leader>e', vim.diagnostic.open_float)
map('n', '<leader>q', vim.diagnostic.setloclist)

map('n', 'ga', vim.lsp.buf.code_action) -- go action
map('v', 'ga', ':lua vim.lsp.buf.range_code_action()<CR>')
map('n', 'ge', vim.lsp.codelens.run) -- go exec

map('n', '=', vim.lsp.buf.format)

-- go calls incoming
-- map('n', 'gci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')

-- go calls outgoing
-- map('n', 'gco', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')

-- go symbols
map('n', 'gs', vim.lsp.buf.document_symbol)
map('n', 'gS', vim.lsp.buf.workspace_symbol)

-- go workspace
map('n', 'gwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end)
map('n', 'gwa', vim.lsp.buf.add_workspace_folder)
map('n', 'gwr', vim.lsp.buf.remove_workspace_folder)

-- telescope
-- Default mappings:
-- https://github.com/nvim-telescope/telescope.nvim#default-mappings
-- <C-x> open selection as split
-- <C-v> open selection as vsplit

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>st', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = '[S]earch [T]ree' })

-- <C-e> creates files and dirs
-- map('n', '-', ':lua require"telescope.builtin".file_browser()<CR>')
map('n', '<leader>gf', function() require"telescope.builtin".git_files { previewer = false } end)
map('n', '<leader>gs', function() require"telescope.builtin".git_status() end)

map('n', '<leader>b', ':JABSOpen<CR>')

-- gc -- vmode comment/uncomment
-- gcc -- comment/uncomment with motions allowed

-- miniyank
-- vim.cmd('map p <Plug>(miniyank-autoput)')
-- vim.cmd('map P <Plug>(miniyank-autoPut)')
-- vim.cmd('map <leader>p <Plug>(miniyank-startput)')
-- vim.cmd('map <leader>P <Plug>(miniyank-startPut)')
-- vim.cmd('map <leader>n <Plug>(miniyank-cycle)')
-- vim.cmd('map <leader>N <Plug>(miniyank-cycleback)')

---
vim.cmd('nmap s <Plug>(easymotion-s)')
vim.cmd('map <Leader>j <Plug>(easymotion-j)')
vim.cmd('map <Leader>k <Plug>(easymotion-k)')

-- map('n', '<F2>', ':%s/<C-R>///g<left><left>')

-- "map <c-p> to manually trigger completion
-- imap <silent> <c-p> <Plug>(completion_trigger)



-- " Keep cursor in place after yank
-- " https://ddrscott.github.io/blog/2016/yank-without-jank/
-- vnoremap <expr>y "my\"" . v:register . "y`y"
-- vnoremap Y myY`y

-- inoremap jj <esc>

-- nmap <UP> <C-Y>
-- nmap <DOWN> <C-E>
--
--
-- " This maps Leader + e to exit terminal mode.
-- tnoremap <Leader>e <C-\><C-n>

-- nmap <BS> <C-h>
--
-- if !hasmapto('<Plug>WindowmodeEnter')
-- 	silent! nmap <unique> <Leader>w <Plug>WindowmodeEnter
-- endif
--
--
-- " yy copies a line, use Y for y$
-- nnoremap Y y$
--

-- https://bit.ly/3g6vYIW
function _G.preserve(cmd)
	cmd = string.format('keepjumps keeppatterns execute %q', cmd)
	local original_cursor = vim.fn.winsaveview()
	vim.api.nvim_command(cmd)
	vim.fn.winrestview(original_cursor)
end

map('n', '_$', [[:lua preserve('%s/\\s\\+$//e')<CR>]]) -- Remove trailing spaces
-- map('n', '_=', [[:lua preserve("normal gg=G")<CR>]]) -- Indent entire file


map('n', '<leader>d', ':bp<bar>sp<bar>bn<bar>bd<CR>') -- Buffer delete

-- move closing paren to next word
-- test(wordhello)
map('i', '<c-u>', '<esc>lxepi')

-- Quickly get out of the closign paren
-- Use arrows instead
-- map('i', '<c-l><c-l>', '<esc>la')


-- " restore position in file
-- au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

-- " Enter acts as C-y when there are drop down menu selections
-- "inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

-- if exists('g:loaded_surround')
--     " vim-surround: q for `foo' and Q for ``foo''
--     let b:surround_{char2nr('q')} = "‘\r’"
--     let b:surround_{char2nr('Q')} = "“\r”"
-- endif

-- nmap ]h <Plug>(GitGutterNextHunk)
-- nmap [h <Plug>(GitGutterPrevHunk)
-- nmap <leader>h <Plug>(GitGutterPreviewHunk)
-- let g:gitgutter_preview_win_floating = 0

-- Debugging
map('n', '<leader>td', ":lua require('dap-go').debug_test()<CR>:lua require('dapui').toggle()<CR>")
map('n', '<leader>tb', ":lua require('dap').toggle_breakpoint()<CR>")
map('n', 'dc', ":lua require('dap').continue()<CR>:lua require('dapui').toggle()<CR>")
map('n', '<F10>', ":lua require('dap').step_over()<CR>")
map('n', '<F11>', ":lua require('dap').step_into()<CR>")
map('n', '<F11>', ":lua require('dap').step_into()<CR>")
map('n', '<F11>', ":lua require('dap').step_into()<CR>")
map('n', '<F11>', ":lua require('dap').step_into()<CR>")

-- Bind <leader>fp to Telescope projections
require('telescope').load_extension('projections')
vim.keymap.set("n", "<leader>fp", function() vim.cmd("Telescope projections") end)
