local add = MiniDeps.add

add({
	source = "folke/which-key.nvim",
})

local opts = {
	preset = "helix",
	spec = {
		{
			mode = { "n", "v" },
			{ "<leader><tab>", group = "tabs" },
			{ "<leader>c", group = "code" },
			{ "<leader>d", group = "debug" },
			{ "<leader>e", group = "encode/decode" },
			{ "<leader>dp", group = "profiler" },
			{ "<leader>f", group = "file/find" },
			{ "<leader>g", group = "git" },
			{ "<leader>gh", group = "hunks" },
			{ "<leader>q", group = "quit/session" },
			{ "<leader>s", group = "search/snippets" },
			{ "<leader>t", group = "telescope" },
			{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
			{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
			{ "[", group = "prev" },
			{ "]", group = "next" },
			{ "g", group = "goto" },
			{ "gs", group = "surround" },
			{ "z", group = "fold" },
			{
				"<leader>b",
				group = "buffer",
				expand = function()
					return require("which-key.extras").expand.buf()
				end,
			},
			{
				"<leader>w",
				group = "windows",
				proxy = "<c-w>",
				expand = function()
					return require("which-key.extras").expand.win()
				end,
			},
			-- better descriptions
			{ "gx", desc = "Open with system app" },
		},
	},
}

local wk = require("which-key")
wk.setup(opts)

wk.triggers = {
	{ "<auto>", mode = "nixsotc" },
	{ "a", mode = { "n", "v" } },
	{ "<leader>", mode = { "n", "v" } },
}

vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = true })
end, { desc = "Buffer Local Keymaps (which-key)" })
