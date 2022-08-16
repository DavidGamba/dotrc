local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
	return
end

navic.setup {
	depth_limit = 0,
	depth_limit_indicator = "..",
}
