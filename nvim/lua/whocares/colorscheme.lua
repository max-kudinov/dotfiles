local colorscheme = "catppuccin"

-- Catppuccin settings
vim.g.catppuccin_flavour = "frappe"
local catppuccin = require("catppuccin")
catppuccin.setup({
	integrations = {
		bufferline = true,
	},
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " is not found")
	return
end
