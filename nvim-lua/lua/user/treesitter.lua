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

	ensure_installed = {
		"go",
		"gomod",
		"gowork",

		"bash",
		"make",

		"yaml",
		"json",
		"hcl",
		"toml",
		"dockerfile",
		"dot",

		"cue",

		"python",
		"typescript",
	}
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.cue = {
  install_info = {
    url = "https://github.com/eonpatapon/tree-sitter-cue",
    files = {"src/parser.c", "src/scanner.c"},
    branch = "main"
  },
  filetype = "cue",
}
