local nvim_treesitter_status_ok, nvim_treesitter = pcall(require, "nvim-treesitter")
if not nvim_treesitter_status_ok then
  return
end

-- local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
-- parser_config.cue = {
--   install_info = {
--     url = "https://github.com/eonpatapon/tree-sitter-cue",
--     files = {"src/parser.c", "src/scanner.c"},
--     branch = "main"
--   },
--   filetype = "cue",
-- }

require'nvim-treesitter.configs'.setup {
	highlight             = {
		enable = true,
		additional_vim_regex_highlighting = false, -- fixes spell check on comments only
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
		"terraform",
		"toml",
		-- "dockerfile",
		"dot",
		"diff",

		"cue",
		"hcl",

		"python",
		"typescript",

		"proto",
		"markdown",
	}
}

local nvim_treesitter_context_status_ok, nvim_treesitter_context = pcall(require, "nvim-treesitter-context")
if not nvim_treesitter_context_status_ok then
  return
end

nvim_treesitter_context.setup {
	enable = true,
	max_lines = 0,
	patterns = {
		default = {
			"class",
			"function",
			"method",
			"for",
			"while",
			"if",
			"else",
			"switch",
			"case",
		},
		rust = {
			"impl_item",
			"mod_item",
			"enum_item",
			"match",
			"struct",
			"loop",
			"closure",
			"async_block",
			"block",
		},
		python = {
			"elif",
			"with",
			"try",
			"except",
		},
		json = {
			"object",
			"pair",
		},
		javascript = {
			"object",
			"pair",
		},
		yaml = {
			"block_mapping_pair",
			"block_sequence_item",
		},
		toml = {
			"table",
			"pair",
		},
		markdown = {
			"section",
		},
	},
}
