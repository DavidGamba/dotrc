local nvim_treesitter_status_ok, _ = pcall(require, "nvim-treesitter")
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
	modules = {},
	highlight             = {
		enable = true,
		additional_vim_regex_highlighting = false, -- fixes spell check on comments only
	},
	indent                = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn", -- set to `false` to disable one of the mappings
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},

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
	},
	sync_install = false,
	auto_install = true,
	ignore_install = {},

  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = true,
    },
		move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = { query = "@class.outer", desc = "Next class start" },

        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
		},
  },
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
