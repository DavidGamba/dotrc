local status_ok, autoclose = pcall(require, "autoclose")
if not status_ok then
	return
end
autoclose.setup({})
