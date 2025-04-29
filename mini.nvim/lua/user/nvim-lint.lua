local add = MiniDeps.add

add({
	source = "mfussenegger/nvim-lint",
})

-- install vale for markdown and asciidoc linting
-- https://vale.sh/docs/install

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
		-- require("lint").try_lint("cspell")
	end,
})

vim.keymap.set("n", "<leader>ll", function()
	require("lint").get_running()
end, { desc = "linter list" })
