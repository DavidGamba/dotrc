local add = MiniDeps.add

add({
	source = "MisanthropicBit/decipher.nvim",
})

require("decipher").setup({})

-- Encode visually selected text as base64. If invoked from normal mode it will
-- try to use the last visual selection
vim.keymap.set({ "n", "v" }, "<leader>eb", function()
	require("decipher").encode_selection("base64")
end, { desc = "encode base64" })

-- Decode encoded text using a motion, selecting a codec and previewing the result
vim.keymap.set({ "n", "v" }, "<leader>eB", function()
	require("decipher").decode_selection("base64")
end, { desc = "decode base64" })

vim.keymap.set({ "n", "v" }, "<leader>ee", function()
	require("decipher").encode_selection_prompt()
end, { desc = "encode" })

vim.keymap.set({ "n", "v" }, "<leader>ed", function()
	require("decipher").decode_selection_prompt()
end, { desc = "encode" })
