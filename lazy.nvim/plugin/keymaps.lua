local set = vim.keymap.set

-- No need to use shift key to run a command
set("n", ";", ":")

-- Save with C-s
set("n", "<C-s>", ":w<CR>")

-- Copy current path
set("n", "cp", ':let @+ = expand("%:p")<CR>')

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

-- Keep visual selection after indentation in visual mode
set("v", "<", "<gv")
set("v", ">", ">gv")

-- Remove trailing spaces
set("n", "_$", [[:lua preserve('%s/\\s\\+$//e')<CR>]])

-- Buffer delete
set("n", "<leader>d", ":bp<bar>sp<bar>bn<bar>bd<CR>")

-- move closing paren to next word
-- test(wordhello)
set("i", "<c-u>", "<esc>lxepi")

-- Toggle hlsearch if it's on, otherwise just do "enter"
set("n", "<CR>", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.hlsearch:get() then
    vim.cmd.nohl()
    return ""
  else
    return "<CR>"
  end
end, { expr = true })

-- There are builtin keymaps for this now, but I like that it shows
-- the float when I navigate to the error - so I override them.
set("n", "]d", vim.diagnostic.goto_next)
set("n", "[d", vim.diagnostic.goto_prev)
