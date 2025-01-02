local add = MiniDeps.add

add({
	source = "mfussenegger/nvim-lint",
})

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
		-- require("lint").try_lint("cspell")
	end,
})
