--[[
-- Setup initial configuration,
-- 
-- Primarily just download and execute lazy.nvim
--]]
vim.g.mapleader = " "

-- ~/.local/share/nvim/lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

-- Add lazy to the `runtimepath`, this allows us to `require` it.
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set up lazy, and load the `lua/custom/plugins/` folder
local plugins = {
  { import = "custom/plugins" },
}
require("lazy").setup(plugins, {
  change_detection = {
    notify = false,
  },
})
