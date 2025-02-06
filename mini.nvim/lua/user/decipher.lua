local add = MiniDeps.add

add({
	source = "MisanthropicBit/decipher.nvim",
})

require("decipher").setup({})

-- Encode visually selected text as base64. If invoked from normal mode it will
-- try to use the last visual selection
vim.keymap.set({ "n", "v" }, "<leader>eb", function()
	require("decipher").encode_selection("base64")
end)

-- Decode encoded text using a motion, selecting a codec and previewing the result
vim.keymap.set("n", "<leader>eB", function()
	require("decipher").decode_motion_prompt({ preview = true })
end)
