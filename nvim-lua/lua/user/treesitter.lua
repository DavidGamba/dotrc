	require'nvim-treesitter.configs'.setup {
		highlight             = {
			enable = true,
			additional_vim_regex_highlighting = true, -- fixes spell check on comments only
		},
		indent                = { enable = true },
		incremental_selection = { enable = true },
		textobjects           = { enable = true },
	}
