return {
  -- the colorscheme should be available when starting Neovim
  {
    "MetriC-DT/balance-theme.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd.colorscheme "balance"

      vim.opt.background = "light"
    end,
  },
  "folke/tokyonight.nvim",
  "projekt0n/github-nvim-theme",
  "sainnhe/edge",
  "yorik1984/newpaper.nvim",
  "Mofiqul/vscode.nvim",
  "MetriC-DT/balance-theme.nvim",
  "navarasu/onedark.nvim",
}
