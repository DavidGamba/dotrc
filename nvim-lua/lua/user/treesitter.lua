local nvim_treesitter_status_ok, nvim_treesitter = pcall(require, "nvim-treesitter")
if not nvim_treesitter_status_ok then
  return
end

require'nvim-treesitter.configs'.setup {
	highlight             = {
		enable = true,
		additional_vim_regex_highlighting = true, -- fixes spell check on comments only
	},
	indent                = { enable = true },
	incremental_selection = { enable = true },
	textobjects           = { enable = true },
}
