local status_ok, lint = pcall(require, "lint")
if not status_ok then
	return
end

lint.linters_by_ft = {
	go = { "golangcilint" },
	sh = { "shellcheck" },
	yaml = { "yamllint" },
	lua = { "luacheck" },
	json = { "jsonlint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})
