vim.pack.add({
	-- deps
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/antoinemadec/FixCursorHold.nvim",
	"https://github.com/andythigpen/nvim-coverage",
	-- Test adapters
	"https://github.com/fredrikaverpil/neotest-golang",
	-- src
	"https://github.com/nvim-neotest/neotest",
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
}
-- Specify custom configuration
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
