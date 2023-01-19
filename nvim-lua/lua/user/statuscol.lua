local status_ok, statuscol = pcall(require, "statuscol")
if not status_ok then
	return
end

statuscol.setup({
	setopt = true
})
