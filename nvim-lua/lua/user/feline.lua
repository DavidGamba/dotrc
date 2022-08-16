local status_ok, feline = pcall(require, "feline")
if not status_ok then
	return
end

local navic = require("nvim-navic")

local get_filename = function()
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"
  local f = require "user.functions"

  if not f.isempty(filename) then
    local file_icon, file_icon_color = require("nvim-web-devicons").get_icon_color(
      filename,
      extension,
      { default = true }
    )

    local hl_group = "FileIconColor" .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if f.isempty(file_icon) then
      file_icon = ""
      file_icon_color = ""
    end

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#LineNr#" .. filename .. "%*"
  end
end

feline.setup()

feline.winbar.setup({
	components = {
		inactive = {
			{
				{
					hl = {
						bg = 'white',
						fg = 'black'
					},
					provider = {
						name = "file_info",
						opts = {
							type = "relative",
						},
					},
				},
				{
					provider = function()
						return " | " .. navic.get_location()
					end,
					enabled = function()
						return navic.is_available()
					end
				},
			},
		},
		active = {
			{
				{
					provider = {
						name = "file_info",
						opts = {
							type = "relative",
						},
					},
				},
				{
					provider = function()
						return " | " .. navic.get_location()
					end,
					enabled = function()
						return navic.is_available()
					end
				},
			},
		},
	},
})

