return {
  {
    "luukvbaal/statuscol.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
    },
    config = function()
      require("statuscol").setup {}
    end,
  },
}
