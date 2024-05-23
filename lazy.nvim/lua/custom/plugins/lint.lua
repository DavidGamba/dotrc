return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        go = { "golangcilint" },
        sh = { "shellcheck" },
        yaml = { "yamllint" },
        lua = { "luacheck" },
        json = { "jsonlint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
