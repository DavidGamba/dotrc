local add = MiniDeps.add

add({
	source = "stevearc/oil.nvim",
	depends = { "nvim-tree/nvim-web-devicons" },
})

require("oil").setup({
	columns = { "icon" },
	keymaps = {
		-- ["<C-h>"] = false,
		-- ["<M-h>"] = "actions.select_split",
	},
	view_options = {
		show_hidden = true,
	},
	-- EXPERIMENTAL support for performing file operations with git
	git = {
		-- Return true to automatically git add/mv/rm files
		add = function(path)
			return false
		end,
		mv = function(src_path, dest_path)
			return true
		end,
		rm = function(path)
			return false
		end,
	},
})

-- Open parent directory in current window
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Open parent directory in floating window
vim.keymap.set("n", "<space>-", require("oil").toggle_float, { desc = "Floating directory viewer" })
