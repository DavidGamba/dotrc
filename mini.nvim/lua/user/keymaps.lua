local map = vim.keymap.set

-- No need to use shift key to run a command
map("n", ";", ":")

-- Save with C-s
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Copy current path
map("n", "cp", ':let @+ = expand("%:p")<CR>', { desc = "Copy current path" })

-- Move visually selected text up and down
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Navigate buffers
map("n", "LL", ":bnext<CR>")
map("n", "HH", ":bprevious<CR>")

-- Move around splits
map("n", "<C-J>", ":wincmd j<CR>")
map("n", "<C-K>", ":wincmd k<CR>")
map("n", "<C-H>", ":wincmd h<CR>")
map("n", "<C-L>", ":wincmd l<CR>")

-- Resize splits
map("n", "<C-Up>", ":resize +3<CR>")
map("n", "<C-Down>", ":resize -3<CR>")
map("n", "<C-Right>", ":vertical resize +5<CR>")
map("n", "<C-Left>", ":vertical resize -5<CR>")

-- Keep visual selection after indentation in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Remove trailing spaces
-- https://bit.ly/3g6vYIW
function _G.preserve(cmd)
	cmd = string.format("keepjumps keeppatterns execute %q", cmd)
	local original_cursor = vim.fn.winsaveview()
	vim.api.nvim_command(cmd)
	vim.fn.winrestview(original_cursor)
end
map("n", "_$", [[:lua preserve('%s/\\s\\+$//e')<CR>]])

-- Buffer delete
-- map("n", "<leader>bd", ":bp<bar>sp<bar>bn<bar>bd<CR>", { desc = "Buffer delete" })

-- move closing paren to next word
-- test(wordhello)
map("i", "<c-u>", "<esc>lxepi")

-- Toggle hlsearch if it's on, otherwise just do "j"
map("n", "j", function()
	---@diagnostic disable-next-line: undefined-field
	if vim.opt.hlsearch:get() then
		vim.cmd.nohl()
		return "j"
	else
		return "j"
	end
end, { expr = true })

-- There are builtin keymaps for this now, but I like that it shows
-- the float when I navigate to the error - so I override them.
map("n", "]d", vim.diagnostic.goto_next)
map("n", "[d", vim.diagnostic.goto_prev)

-- Encode/decode base64 (k -> kubernetes)
map("v", "[k", "c<c-r>=system('base64 --decode', @\")<cr><esc>", { desc = "base64 decode" })
map("v", "]k", "c<c-r>=system('base64', @\")<cr><esc>", { desc = "base64 encode" })

map("v", "<c-c>", '"*y', { desc = "Copy to system clipboard" })

map("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / Clear hlsearch / Diff Update" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })
