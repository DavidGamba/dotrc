return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            {
              "filename",
              path = 3,
            },
            {
              "diagnostics",
              -- sources = setting_diagnostics.sources,
              -- symbols = setting_diagnostics.symbols,
              -- colored = setting_diagnostics.colored,
              -- update_in_insert = setting_diagnostics.update_in_insert,
              -- always_visible = setting_diagnostics.always_visible,
            },
          },
          lualine_c = { "diff" },
          lualine_x = { "filetype" },
          lualine_y = { "fileformat", "encoding" },
          lualine_z = { "location", "progress" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              path = 3,
            },
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        -- winbar = winbar,
        -- inactive_winbar = winbar,
        -- tabline = {
        --   lualine_a = {},
        --   lualine_b = {},
        --   lualine_c = { cwd },
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = { "tabs" },
        -- },
      }
    end,
  },
}
