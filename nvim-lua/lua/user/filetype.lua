local filetype = function(ext, type)
	vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
		pattern = {ext},
		command = "set filetype=" .. type,
	})
end

filetype("*.cue", "cue")