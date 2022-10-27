-- Nvim tree setup

require("nvim-tree").setup({
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	git = {
		enable = false,
	},
})
