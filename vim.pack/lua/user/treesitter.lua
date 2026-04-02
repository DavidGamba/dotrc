vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "update" or kind == "install") then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

-- require("nvim-treesitter.configs").setup({
--
-- 	highlight = { enable = true },
-- 	indent = { enable = true },
--
-- 	incremental_selection = {
-- 		enable = true,
-- 		keymaps = {
-- 			init_selection = "<C-space>",
-- 			node_incremental = "<C-space>",
-- 			scope_incremental = false,
-- 			node_decremental = "<bs>",
-- 		},
-- 	},
--
-- 	textobjects = {
-- 		swap = {
-- 			enable = true,
-- 			swap_next = {
-- 				["<leader>a"] = "@parameter.inner",
-- 			},
-- 			swap_previous = {
-- 				["<leader>A"] = "@parameter.inner",
-- 			},
-- 		},
-- 		move = {
-- 			enable = true,
-- 			goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
-- 			goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
-- 			goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
-- 			goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
-- 		},
-- 	},
-- })

require("nvim-treesitter").install({
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
})
