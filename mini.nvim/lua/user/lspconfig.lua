local add = MiniDeps.add

add({
	source = "neovim/nvim-lspconfig",
	depends = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
})

local lspconfig = require("lspconfig")
-- require("lspconfig").setup({})

lspconfig.gopls.setup({})
lspconfig.terraformls.setup({})
lspconfig.cue.setup({})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

		vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

		vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { buffer = 0, desc = "Lsp Info" })

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "definition" })
		vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, { buffer = 0, desc = "definition" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0, desc = "references" })
		vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0, desc = "Implementation" }) -- go implementation
		vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = 0, desc = "T[y]pe Definition" }) -- go list type
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "Declaration" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Hover" })
		vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = 0, desc = "Signature Help" })
		vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { buffer = 0, desc = "Signature Help" })

		-- actions
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = 0, desc = "Code Action" })
		vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { buffer = 0, desc = "Run Codelens" })
		vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, { buffer = 0, desc = "Refresh Codelens" })
		vim.keymap.set("n", "<leader>cR", function()
			Snacks.rename.rename_file()
		end, { buffer = 0, desc = "Rename File" })
		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0, desc = "Rename" })
		vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = 0, desc = "" })

		vim.keymap.set("n", "]]", function()
			Snacks.words.jump(vim.v.count1)
		end, { buffer = 0, desc = "Next Reference" })
		vim.keymap.set("n", "[[", function()
			Snacks.words.jump(-vim.v.count1)
		end, { buffer = 0, desc = "Prev Reference" })
		vim.keymap.set("n", "<a-n>", function()
			Snacks.words.jump(vim.v.count1, true)
		end, { buffer = 0, desc = "Next Reference" })
		vim.keymap.set("n", "<a-p>", function()
			Snacks.words.jump(-vim.v.count1, true)
		end, { buffer = 0, desc = "Prev Reference" })

		-- workspace
		vim.keymap.set("n", "gwa", vim.lsp.buf.add_workspace_folder, { buffer = 0, desc = "Add Workspace Folder" })
		vim.keymap.set("n", "gwr", vim.lsp.buf.remove_workspace_folder, { buffer = 0, desc = "Remove Workspace Folder" })
		vim.keymap.set("n", "gwl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = 0, desc = "List workspace folders" })

		-- document
		vim.keymap.set("n", "gws", vim.lsp.buf.document_symbol, { buffer = 0, desc = "Document Symbol" })
		vim.keymap.set("n", "gwS", vim.lsp.buf.workspace_symbol, { buffer = 0, desc = "Workspace Symbol" })

		vim.keymap.set("n", "=", vim.lsp.buf.format, { buffer = 0, desc = "Format" })
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, { buffer = 0, desc = "Format" })
	end,
})

vim.api.nvim_create_autocmd("LspDetach", {
	callback = function(opt)
		vim.lsp.codelens.clear(opt.data.client_id, opt.buf)
	end,
})
