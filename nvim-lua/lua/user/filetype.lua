local filetype = function(ext, type)
	vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
		pattern = {ext},
		command = "set filetype=" .. type,
	})
end

filetype("*.cue", "cue")

if vim.bo.filetype == 'cue' then
	vim.bo.commentstring = '//%s'
end

if vim.bo.filetype == 'asciidoc' then
	vim.bo.expandtab = true
end

-- $ python -m venv ~/venvs/jedi && source ~/venvs/jedi/bin/activate && pip install jedi
-- $ python -m venv ~/venvs/neovim && source ~/venvs/neovim/bin/activate && pip install neovim
-- $ python -m venv ~/venvs/black && source ~/venvs/black/bin/activate && pip install black
-- $ python -m venv ~/venvs/pylint && source ~/venvs/pylint/bin/activate && pip install pylint pylint-venv
vim.g.python3_host_prog="~/venvs/neovim/bin/python"
