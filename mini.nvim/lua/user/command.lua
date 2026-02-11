local add = MiniDeps.add

add({
	source = "vieitesss/command.nvim",
})

-- :CommandExecute command ${selection:sh}
require("command").setup({})
