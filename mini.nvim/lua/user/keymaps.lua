local set = vim.keymap.set

-- No need to use shift key to run a command
set("n", ";", ":")

-- Save with C-s
set("n", "<C-s>", ":w<CR>", { desc = "Save" })

-- Copy current path
set("n", "cp", ':let @+ = expand("%:p")<CR>', { desc = "Copy current path" })

-- Move visually selected text up and down
set("x", "J", ":move '>+1<CR>gv-gv")
set("x", "K", ":move '<-2<CR>gv-gv")

-- Navigate buffers
set("n", "LL", ":bnext<CR>")
set("n", "HH", ":bprevious<CR>")

-- Move around splits
set("n", "<C-J>", ":wincmd j<CR>")
set("n", "<C-K>", ":wincmd k<CR>")
set("n", "<C-H>", ":wincmd h<CR>")
set("n", "<C-L>", ":wincmd l<CR>")

-- Resize splits
set("n", "<C-Up>", ":resize +1<CR>")
set("n", "<C-Down>", ":resize -1<CR>")
-- TODO
set("n", "<C-Right>", ":vertical resize +1<CR>")
set("n", "<C-Left>", ":vertical resize -1<CR>")

-- Keep visual selection after indentation in visual mode
set("v", "<", "<gv")
set("v", ">", ">gv")

-- Remove trailing spaces
-- https://bit.ly/3g6vYIW
function _G.preserve(cmd)
	cmd = string.format("keepjumps keeppatterns execute %q", cmd)
	local original_cursor = vim.fn.winsaveview()
	vim.api.nvim_command(cmd)
	vim.fn.winrestview(original_cursor)
end
set("n", "_$", [[:lua preserve('%s/\\s\\+$//e')<CR>]])

-- Buffer delete
-- set("n", "<leader>d", ":bp<bar>sp<bar>bn<bar>bd<CR>", { desc = "Buffer delete" })

-- move closing paren to next word
-- test(wordhello)
set("i", "<c-u>", "<esc>lxepi")

-- Toggle hlsearch if it's on, otherwise just do "j"
set("n", "j", function()
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
set("n", "]d", vim.diagnostic.goto_next)
set("n", "[d", vim.diagnostic.goto_prev)

-- Encode/decode base64 (k -> kubernetes)
set("v", "[k", "c<c-r>=system('base64 --decode', @\")<cr><esc>", { desc = "base64 decode" })
set("v", "]k", "c<c-r>=system('base64', @\")<cr><esc>", { desc = "base64 encode" })

set("v", "<c-c>", '"*y', { desc = "Copy to system clipboard" })
