return {
  {
    "tpope/vim-unimpaired",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "tpope/vim-surround",
    config = function() end,
  },
  {
    -- Provides CoeRce MixedCase (crm), CoeRce camelCase (crc), CoeRce snake_case (crs), and CoeRce UPPER_CASE (cru)
    "tpope/vim-abolish",
    config = function() end,
  },
  {
    "almo7aya/openingh.nvim",
    config = function() end,
  },
  {
    "Wansmer/treesj",
    -- keys = { "<space>m", "<space>j", "<space>p" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local tsj = require "treesj"
      vim.keymap.set("n", "<leader>m", tsj.toggle)
      vim.keymap.set("n", "<leader>p", tsj.split)
      vim.keymap.set("n", "<leader>j", tsj.join)

      tsj.setup {
        use_default_keymaps = false,
      }
    end,
  },
}
