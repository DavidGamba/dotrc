local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require 'lspconfig'
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	require "lsp_signature".on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded"
		}
	})

-- Set autocommands conditional on server_capabilities
if client.resolved_capabilities.document_highlight then
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
}
