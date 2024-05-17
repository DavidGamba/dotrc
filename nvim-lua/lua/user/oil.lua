-- local git_ok, git = pcall(require, "oil-git-status")
-- if not git_ok then
-- 	return
-- end

local status_ok, oil = pcall(require, "oil")
if not status_ok then
	return
end

oil.setup({
	view_options = {
		show_hidden = true,
	},
	win_options = {
		signcolumn = "yes:2",
	},
	-- EXPERIMENTAL support for performing file operations with git
	git = {
		-- Return true to automatically git add/mv/rm files
		add = function(path)
		 return false
		end,
		mv = function(src_path, dest_path)
		 return false
		end,
		rm = function(path)
		 return false
		end,
	},
})

-- git.setup{}
