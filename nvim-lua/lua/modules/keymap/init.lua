-- keymap function
local map = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {
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

-- navigation
map('n', 'k', 'gk')
map('n', 'j', 'gj')

-- Move around splits
map('n', '<C-J>', ':wincmd j<CR>')
map('n', '<C-K>', ':wincmd k<CR>')
map('n', '<C-H>', ':wincmd h<CR>')
map('n', '<C-L>', ':wincmd l<CR>')

-- Keep visual selection after indentation in visual mode
map('v', '<', '<gv')
map('v', '>', '>gv')

map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>') -- go Declaration
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>') -- go definition
map('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
-- Not implemented in gopls
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.peek_definition()<CR>', opts)

map('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>') -- go hover

map('n', 'gli', '<cmd>lua vim.lsp.buf.implementation()<CR>') -- go list imlementation

map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>') -- go signature

map('n', 'glt', '<cmd>lua vim.lsp.buf.type_definition()<CR>') -- go to type

map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>') -- Rename with same keymapping as vscode

map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>') -- go references

map('n', 'gld', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>') -- go line diagnostic
map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

map('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>') -- go action
-- map('v', '<leader>a', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
map('v', '<leader>a', ':lua vim.lsp.buf.range_code_action()<CR>')

map('n', '=', '<cmd>lua vim.lsp.buf.formatting()<CR>')

-- go calls incoming
-- map('n', 'gci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')

-- go calls outgoing
-- map('n', 'gco', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')

-- go workspace
map('n', 'gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

-- go Workspace
map('n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')

-- telescope
-- Default mappings:
-- https://github.com/nvim-telescope/telescope.nvim#default-mappings
-- <C-x> open selection as split
-- <C-v> open selection as vsplit
map('n', '<C-p>', ':lua require"telescope.builtin".find_files { previewer = false }<CR>')
map('n', '<M-b>', ':lua require"telescope.builtin".buffers()<CR>')
map('n', '<M-f>', ':lua require"telescope.builtin".live_grep()<CR>')
-- <C-e> creates files and dirs
-- map('n', '-', ':lua require"telescope.builtin".file_browser()<CR>')
map('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
map('n', '<leader>gf', ':lua require"telescope.builtin".git_files { previewer = false }<CR>')
map('n', '<leader>gs', ':lua require"telescope.builtin".git_status()<CR>')

-- gc -- vmode comment/uncomment
-- gcc -- comment/uncomment with motions allowed

-- miniyank
vim.cmd('map p <Plug>(miniyank-autoput)')
vim.cmd('map P <Plug>(miniyank-autoPut)')
vim.cmd('map <leader>p <Plug>(miniyank-startput)')
vim.cmd('map <leader>P <Plug>(miniyank-startPut)')
vim.cmd('map <leader>n <Plug>(miniyank-cycle)')
vim.cmd('map <leader>N <Plug>(miniyank-cycleback)')

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

-- Quickly get out of the closign paren
-- inoremap <C-l><C-l> <ESC>la

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
