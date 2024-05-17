local status_ok, mini = pcall(require, "mini.align")
if not status_ok then
	return
end

mini.setup({
	mappings = {
		start = '<leader>a',
		start_with_preview = '<leader>A',
	}
})
