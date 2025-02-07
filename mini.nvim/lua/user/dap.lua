local add = MiniDeps.add

add({
	source = "mfussenegger/nvim-dap",
	depends = {
		"jay-babu/mason-nvim-dap.nvim",
		"williamboman/mason.nvim",
		"leoluz/nvim-dap-go",
	},
})

add({
	source = "rcarriga/nvim-dap-ui",
	depends = {
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-dap",
	},
})

add({
	source = "theHamsta/nvim-dap-virtual-text",
	depends = {
		"mfussenegger/nvim-dap",
	},
})

add({
	source = "Weissle/persistent-breakpoints.nvim",
	depends = {
		"mfussenegger/nvim-dap",
	},
})

local dap = require("dap")
require("dapui").setup({})
require("nvim-dap-virtual-text").setup({})
require("mason-nvim-dap").setup()
require("dap-go").setup()
require("persistent-breakpoints").setup({
	load_breakpoints_event = { "BufReadPost" },
})

vim.keymap.set("n", "<leader>du", function()
	require("dapui").toggle({})
end, { desc = "Dap UI" })

vim.keymap.set({ "n", "v" }, "<leader>de", function()
	require("dapui").eval()
end, { desc = "Eval" })

-- stylua: ignore
local keys = {
	  { "<leader>dB", function() require('persistent-breakpoints.api').set_conditional_breakpoint() end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require('persistent-breakpoints.api').toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dD", function() require('persistent-breakpoints.api').clear_all_breakpoints() end, desc = "Clear all Breakpoints" },
    { "<leader>dL", function() require('persistent-breakpoints.api').set_log_point() end, desc = "Set log point" },
	  -- { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    -- { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
}

for _, v in ipairs(keys) do
	vim.keymap.set("n", v[1], v[2], { desc = v.desc })
end

vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })
--
vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
-- ❔
vim.fn.sign_define("DapBreakpointCondition", { text = "❓", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
