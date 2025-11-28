local add = MiniDeps.add

add({
	source = "stevearc/oil.nvim",
	depends = { "nvim-tree/nvim-web-devicons" },
})

add({
	source = "refractalize/oil-git-status.nvim",
	depends = { "stevearc/oil.nvim" },
})

local oil = require("oil")

oil.setup({
	win_options = {
		signcolumn = "yes:2",
	},
	columns = { "icon" },
	keymaps = {
		-- Don't use motions I use for window management for splits
		["<C-h>"] = false,
		["<C-l>"] = false,
		-- Splits
		["<C-s>"] = { "actions.select", opts = { horizontal = true } },
		["<C-v>"] = { "actions.select", opts = { vertical = true } },
		["<leader>ga"] = function()
			local cwd = oil.get_current_dir()
			local entry = oil.get_cursor_entry()
			if cwd and entry then
				local pos = vim.fn.getcurpos()
				local line = pos[2]
				local col = pos[3]
				vim.fn.jobstart({ "git", "add", string.format("%s/%s", cwd, entry.name) })
				oil.open(cwd)
				print("Cursor Position: Line " .. line .. ", Column " .. col)
				vim.fn.cursor(line, 0)
			end
		end,
		["<leader>gr"] = function()
			local cwd = oil.get_current_dir()
			local entry = oil.get_cursor_entry()
			if cwd and entry then
				local pos = vim.fn.getcurpos()
				local line = pos[2]
				local col = pos[3]
				vim.fn.jobstart({ "git", "reset", string.format("%s/%s", cwd, entry.name) })
				oil.open(cwd)
				print("Cursor Position: Line " .. line .. ", Column " .. col)
				vim.fn.cursor(line, 0)
			end
		end,
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

require("oil-git-status").setup()

-- Open parent directory in current window
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Open parent directory in floating window
vim.keymap.set("n", "<space>-", require("oil").toggle_float, { desc = "Floating directory viewer" })
