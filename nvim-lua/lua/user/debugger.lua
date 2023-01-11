local dap_go_status_ok, dap_go = pcall(require, "dap-go")
if not dap_go_status_ok then
  return
end

local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
  return
end

dap_go.setup()
dapui.setup {}
-- require'go'.setup {
-- 	goimport = 'gopls', -- if set to 'gopls' will use golsp format
-- 	gofmt = 'gopls', -- if set to gopls will use golsp format
-- 	lsp_cfg = true,
-- 	dap_debug = true,
-- 	dap_debug_keymap = true,
-- 	dap_debug_gui = true,
-- }
-- local protocol = require'vim.lsp.protocol'
-- use {'sebdah/vim-delve', ft = {'go'} }
