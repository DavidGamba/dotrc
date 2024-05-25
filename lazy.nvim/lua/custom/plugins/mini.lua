return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup()
      require("mini.surround").setup()
      require("mini.jump").setup()
      require("mini.jump2d").setup()
      require("mini.tabline").setup()
      require("mini.align").setup()
      require("mini.cursorword").setup()
    end,
  },
}
