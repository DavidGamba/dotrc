vim.filetype.add({
	extension = {
		cue = "cue",
		tfvars = "terraform-vars",
		tmpl = "gotmpl",
		gotmpl = "gotmpl",
	},
	filename = {
		["go.work"] = "gowork",
	},
})

-- enable TS highlighting for any buffer that has a parser installed
-- Should be done after registering the additional filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		local lang = vim.treesitter.language.get_lang(ft)

		if not vim.treesitter.language.add(lang) then
			-- this stupid tracking is here only because
			-- they have added warnings on absent parsers
			local available = vim.g.ts_available or require("nvim-treesitter").get_available()
			if not vim.g.ts_available then
				vim.g.ts_available = available
			end
			if vim.tbl_contains(available, lang) then
				require("nvim-treesitter").install(lang)
			end
		end

		if vim.treesitter.language.add(lang) then
			vim.treesitter.start(args.buf, lang)
			-- this is an experimental feature
			-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[0][0].foldmethod = "expr"
		end
	end,
})
