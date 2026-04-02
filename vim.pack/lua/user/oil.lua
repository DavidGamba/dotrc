vim.pack.add({
	-- deps
	"https://github.com/nvim-tree/nvim-web-devicons",
	-- src
	"https://github.com/stevearc/oil.nvim",
	-- ext
	"https://github.com/refractalize/oil-git-status.nvim",
})

local oil = require("oil")

local oil_git_status = require("oil-git-status")

oil.setup({
	win_options = {
		signcolumn = "yes:2",
	},
	columns = { "icon" },
	keymaps = {
		-- Show help with g?
		["<esc>"] = { "actions.refresh" },
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
				-- Alternative way to refresh oil view natively
				-- vim.api.nvim_create_autocmd("User", {
				-- 	pattern = "OilEnter",
				-- 	once = true,
				-- 	callback = function()
				-- 		vim.schedule(function()
				-- 			vim.fn.cursor(line, 0)
				-- 		end)
				-- 	end,
				-- })
				-- oil.open(cwd)
				oil_git_status.refresh_buffer(0)
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
				-- Alternative way to refresh oil view natively
				-- vim.api.nvim_create_autocmd("User", {
				-- 	pattern = "OilEnter",
				-- 	once = true,
				-- 	callback = function()
				-- 		vim.schedule(function()
				-- 			vim.fn.cursor(line, 0)
				-- 		end)
				-- 	end,
				-- })
				-- oil.open(cwd)
				oil_git_status.refresh_buffer(0)
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
	watch_for_changes = true,
})

oil_git_status.setup()

-- Open parent directory in current window
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Open parent directory in floating window
vim.keymap.set("n", "<space>-", require("oil").toggle_float, { desc = "Floating directory viewer" })
