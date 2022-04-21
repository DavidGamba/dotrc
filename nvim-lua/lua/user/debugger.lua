	require'dap-go'.setup {}
	require'dapui'.setup {}
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
	vim.api.nvim_command("autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)")
