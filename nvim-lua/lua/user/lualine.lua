local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
	return
end

local navic = require('nvim-navic')

local setting_diagnostics = {
	sources = { 'nvim_lsp' },
	colored = true,
	update_in_insert = false,
	always_visible = false,
}

local function navic_location()
	local none_display = "📄"
	if navic.is_available() then
		local l = navic.get_location()
		return (l ~= "") and l or none_display
	else
		return none_display
	end
end

local function cwd()
	return vim.fn.substitute(vim.fn.getcwd(0), os.getenv("HOME"), '~', "")
end

local winbar = {
	lualine_a = {
		{ 'filename', path = 1},
	},
	lualine_b = {
		{ navic_location }
	},
}

lualine.setup({
	options = {
		icons_enabled = true,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = {
			{
				'filename',
				path = 3,
			},
			{
				'diagnostics',
				sources = setting_diagnostics.sources,
				symbols = setting_diagnostics.symbols,
				colored = setting_diagnostics.colored,
				update_in_insert = setting_diagnostics.update_in_insert,
				always_visible = setting_diagnostics.always_visible,
			}
		},
		lualine_c = { 'diff' },
		lualine_x = { 'filetype' },
		lualine_y = { 'fileformat', 'encoding' },
		lualine_z = { 'location', 'progress' },
	},
	inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
			{
				'filename',
				path = 3,
			},
		},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
	winbar = winbar,
	inactive_winbar = winbar,
	tabline = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {cwd},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {'tabs'}
	}
})
