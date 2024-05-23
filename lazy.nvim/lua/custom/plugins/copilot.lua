return {
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_filetypes = { xml = false }
      vim.cmd "inoremap <M-i> <Plug>(copilot-next)"
      vim.cmd "inoremap <M-u> <Plug>(copilot-previous)"
    end,
  },
}
