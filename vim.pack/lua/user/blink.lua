vim.pack.add({
	-- deps
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/saghen/blink.compat",
	"https://github.com/giuxtaposition/blink-cmp-copilot",
})
vim.pack.add({
	{
		src = "https://github.com/saghen/blink.cmp",
		version = "v1.10.2",
	},
})

require("blink.cmp").setup({
	appearance = {
		-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
	},
	completion = {
		keyword = {
			range = "prefix",
		},
		accept = {
			-- experimental auto-brackets support
			auto_brackets = {
				enabled = false,
			},
		},
		menu = {
			draw = {
				treesitter = { "lsp" },
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		ghost_text = {
			enabled = vim.g.ai_cmp,
		},
	},

	fuzzy = { implementation = "prefer_rust_with_warning" },

	-- experimental signature help support
	signature = { enabled = true },

	cmdline = {
		enabled = false,
	},

	sources = {
		-- adding any nvim-cmp sources here will enable them
		-- with blink.compat
		default = { "lsp", "path", "snippets", "buffer", "copilot" },
		-- default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			copilot = {
				name = "copilot",
				module = "blink-cmp-copilot",
				score_offset = 100,
				async = true,
			},
		},
	},

	keymap = {
		preset = "default",
		["<C-e>"] = { "hide", "fallback" },
		["<C-y>"] = { "select_and_accept", "fallback" },

		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-n>"] = { "select_next", "fallback_to_mappings" },

		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },

		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },

		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
	},
})
