local add = MiniDeps.add

add({
	source = "stevearc/conform.nvim",
})

require("conform").setup({
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 3000,
		lsp_format = "fallback",
	},
	default_format_opts = {
		timeout_ms = 3000,
		async = false, -- not recommended to change
		quiet = false, -- not recommended to change
		lsp_format = "fallback", -- not recommended to change
	},
	formatters_by_ft = {
		lua = { "stylua" },
		sh = { "shfmt" },
		cue = { "cue" },
		terraform = { "terraform_fmt" },
	},
	formatters = {
		cue = {
			command = "cue",
			args = { "fmt", "$FILENAME" },
			stdin = false,
		},
	},
})
