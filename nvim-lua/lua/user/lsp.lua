local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
	return
end

local navic_ok, navic = pcall(require, "nvim-navic")
if not navic_ok then
	return
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
	return
end

local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
if not lsp_signature_ok then
	return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

vim.lsp.set_log_level("off")

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	lsp_signature.on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded"
		}
	})

	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	if client.supports_method("textDocument/codeLens") then
		vim.api.nvim_create_autocmd({ "CursorHold","InsertLeave" }, {
			callback = vim.lsp.codelens.refresh,
		})
	end

	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec([[
	hi LspReferenceRead cterm=bold ctermbg=LightYellow guibg=LightYellow
	hi LspReferenceText cterm=bold ctermbg=LightYellow guibg=LightYellow
	hi LspReferenceWrite cterm=bold ctermbg=LightYellow guibg=LightYellow
	augroup lsp_document_highlight
	autocmd! * <buffer>
	autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
	autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	augroup END
	]], false)
	end
end

vim.api.nvim_set_hl(0, 'LspCodeLens', {fg='#88C0D0', underline=true})


-- [lsp] typescript
lspconfig.tsserver.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = { debounce_text_changes = 400 },
}

-- [lsp] gopls
lspconfig.gopls.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	init_options = {
		analyses = {
			unusedparams = false,
		},
		codelenses = {
			generate           = true,
			gc_details         = true,
			test               = true,
			tidy               = true,
			upgrade_dependency = true,
		},
		usePlaceholders = true,
		completeUnimported = true,
		staticcheck = true,
		matcher = 'fuzzy',
		diagnosticsDelay = '500ms',
		symbolMatcher = 'fuzzy',
		gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
		buildFlags = { '-tags', 'integration' },
	},
}

lspconfig.sumneko_lua.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

lspconfig.terraformls.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { 'terraform', 'tf', 'tfvars' },
}

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.tf", "*.tfvars" },
	callback = function() vim.lsp.buf.format { async = true } end
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.go" },
	callback = function() vim.lsp.buf.format { async = true } end
})
