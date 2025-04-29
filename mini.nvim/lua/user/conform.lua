local add = MiniDeps.add

add({
	source = "stevearc/conform.nvim",
})

require("conform").setup({
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
		json = { "jq" },
		yaml = { "yq" },
	},
	formatters = {
		cue = {
			command = "cue",
			args = { "fmt", "$FILENAME" },
			stdin = false,
		},
	},

	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_fallback = true }
	end,
})

local function show_notification(message, level)
	notify(message, level, { title = "conform.nvim" })
end

vim.api.nvim_create_user_command("FormatToggle", function(args)
	local is_global = not args.bang
	if is_global then
		vim.g.disable_autoformat = not vim.g.disable_autoformat
		if vim.g.disable_autoformat then
			show_notification("Autoformat-on-save disabled globally", "info")
		else
			show_notification("Autoformat-on-save enabled globally", "info")
		end
	else
		vim.b.disable_autoformat = not vim.b.disable_autoformat
		if vim.b.disable_autoformat then
			show_notification("Autoformat-on-save disabled for this buffer", "info")
		else
			show_notification("Autoformat-on-save enabled for this buffer", "info")
		end
	end
end, {
	desc = "Toggle autoformat-on-save",
	bang = true,
})
