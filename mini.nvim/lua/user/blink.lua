local add = MiniDeps.add

add({
	-- https://github.com/saghen/blink.cmp
	source = "saghen/blink.cmp",
	depends = {
		"rafamadriz/friendly-snippets",
		"saghen/blink.compat",
		"giuxtaposition/blink-cmp-copilot",
	},
	checkout = "v1.1.1",
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
				enabled = true,
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
		preset = "enter",
		["<C-y>"] = { "select_and_accept" },
	},
})
