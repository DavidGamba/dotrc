vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
	gitbrowse = { enabled = true },
	rename = { enabled = true },
	words = { enabled = true },
	image = { enabled = true },
	gh = { enabled = true },
})

local map = vim.keymap.set

map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })

-- Git browse
map("n", "<leader>gb", function()
	Snacks.git.blame_line()
end, { desc = "Git Blame Line" })
map({ "n", "x" }, "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "Git Browse (open)" })
map({ "n", "x" }, "<leader>gY", function()
	Snacks.gitbrowse({
		open = function(url)
			vim.fn.setreg("+", url)
		end,
		notify = false,
	})
end, { desc = "Git Browse (copy)" })

-- GH
map("n", "<leader>gp", function()
	Snacks.picker.gh_pr()
end, { desc = "GitHub Pull Requests (Open)" })

-- image
map("n", "<leader>ih", function()
	Snacks.image.hover()
end, { desc = "Image Hover" })
