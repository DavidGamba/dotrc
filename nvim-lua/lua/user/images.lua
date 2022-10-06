local status_ok, hologram = pcall(require, "hologram")
if not status_ok then
	return
end

hologram.setup {
	auto_display = true
}
