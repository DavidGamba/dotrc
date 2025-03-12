local add = MiniDeps.add

add({
	source = "nvim-neotest/neotest",
	depends = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",

		-- Test adapters
		"fredrikaverpil/neotest-golang",
	},
})

add({
	source = "fredrikaverpil/neotest-golang",
	depends = {
		"andythigpen/nvim-coverage",
	},
})

add({
	source = "andythigpen/nvim-coverage",
	depends = {
		"nvim-lua/plenary.nvim",
	},
})

require("coverage").setup()

local neotest_golang_opts = {
	-- go install gotest.tools/gotestsum@latest
	runner = "gotestsum",
	go_test_args = {
		"-v",
		"-race",
		"-count=1",
		"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
	},
} -- Specify custom configuration
require("neotest").setup({
	adapters = {
		require("neotest-golang")(neotest_golang_opts), -- Registration
	},
})

vim.keymap.set("n", "<leader>tt", function()
	require("neotest").run.run()
end, { desc = "test" })

vim.keymap.set("n", "<leader>td", function()
	require("neotest").run.run({ suite = false, strategy = "dap" })
end, { desc = "debug test" })
