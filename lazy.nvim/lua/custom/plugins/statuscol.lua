return {
  {
    "luukvbaal/statuscol.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
    },
    config = function()
      require("gitsigns").setup()
      require("statuscol").setup {}
    end,
  },
}
