local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

cmp.setup({
	snippet = {
		expand = function(args)
		-- For `ultisnips` user.
		vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		-- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		-- -- ['<C-y>'] = cmp.config.disable, -- remove the default `<C-y>` mapping.
		-- ['<CR>'] = cmp.mapping.confirm({ select = true }),

		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
	},
	sources = cmp.config.sources({
		-- For ultisnips user.
		{ name = 'ultisnips' },

		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'nvim_lua' },
	})
})
cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } } )
