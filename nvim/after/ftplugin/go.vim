compiler go
set listchars=tab:\ \ ,trail:·,extends:»,precedes:« " Unprintable chars mapping
" Run gofmt on save
" autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
