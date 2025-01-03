local add = MiniDeps.add

add({
	source = "nvim-treesitter/nvim-treesitter",
})
add({
	source = "nvim-treesitter/nvim-treesitter-textobjects",
	depends = {
		"nvim-treesitter/nvim-treesitter",
	},
})

-- require("nvim-treesitter.query_predicates")
-- require("nvim-treesitter.install").compilers = { "zig" }
require("nvim-treesitter.configs").setup({

	ensure_installed = {
		"bash",
		"css",
		"csv",
		"cue",
		"diff",
		"dot",
		"embedded_template",
		"git_config",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"gnuplot",
		"go",
		"gomod",
		"gosum",
		"gotmpl",
		"gowork",
		"graphql",
		"groovy",
		"hcl",
		"helm",
		"hjson",
		"html",
		"http",
		"ini",
		"java",
		"javascript",
		"jq",
		"jsdoc",
		"json",
		"kotlin",
		"lua",
		"make",
		"markdown",
		"markdown_inline",
		"mermaid",
		"nix",
		"pem",
		"proto",
		"python",
		"regex",
		"rego",
		"ruby",
		"rust",
		"sql",
		"terraform",
		"toml",
		"tsv",
		"typescript",
		"vim",
		"vimdoc",
		"vue",
		"xml",
		"yaml",
	},
	auto_install = true,

	highlight = { enable = true },
	indent = { enable = true },

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},

	textobjects = {
		move = {
			enable = true,
			goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
			goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
			goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
			goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
		},
	},
})
