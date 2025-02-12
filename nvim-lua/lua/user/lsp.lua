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
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true
}

vim.lsp.set_log_level("off")

local on_attach = function(client, bufnr)
	lsp_signature.on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded"
		}
	})

	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	if client.server_capabilities.code_lens then
		vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
			callback = vim.lsp.codelens.refresh,
		})
		vim.api.nvim_set_hl(0, 'LspCodeLens', { fg = '#88C0D0', underline = true })
	end

	if client.supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint(0, false)
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
			gc_details         = false,
			test               = true,
			tidy               = true,
			upgrade_dependency = true,
			run_govulncheck    = true,
		},
		usePlaceholders = true,
		completeUnimported = true,
		staticcheck = true,
		matcher = 'fuzzy',
		diagnosticsDelay = '500ms',
		symbolMatcher = 'fuzzy',
		gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
		buildFlags = { '-tags', 'integration' },
		expandWorkspaceToModule = true,
		hints = {
			assignVariableTypes = true,
			compositeLiteralFields = true,
			compositeLiteralTypes = true,
			constantValues = true,
			functionTypeParameters = true,
			parameterNames = true,
			rangeVariableTypes = true,
		},
	},
}

lspconfig.lua_ls.setup {
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


local cuepls_capabilities = cmp_nvim_lsp.default_capabilities()
cuepls_capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = false
}
cuepls_capabilities.textDocument.hover = {
}

lspconfig.dagger.setup {
	capabilities = cuepls_capabilities,
	on_attach = on_attach,
	cmd = { 'cuepls' }
}

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.tf", "*.tfvars" },
	callback = function() vim.lsp.buf.format { async = true } end
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.go" },
	callback = function() vim.lsp.buf.format { async = true } end
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.cue" },
	callback = function() vim.lsp.buf.format { async = true } end
})
