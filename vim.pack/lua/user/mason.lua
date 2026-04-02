vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
})

require("mason").setup({})

vim.api.nvim_create_user_command("MasonInstallAll", function()
	local packages = table.concat({
		"delve",
		"gopls",
		"gotestsum",
		"copilot-language-server",
		"terraform-ls",
		"vale", -- markdown and asciidoc linting
		"vale-ls",
	}, " ")
	vim.cmd("MasonUpdate")
	vim.cmd("MasonInstall " .. packages)
end, {})
