local colorscheme = "catppuccin"

-- Catppuccin settings
vim.g.catppuccin_flavour = "frappe"
local catppuccin = require"catppuccin"
catppuccin.setup {
	transparent_background = true,
	integrations = {
		bufferline = true,
	}
}

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " is not found")
	return
end

-- fix nvim tree color
vim.cmd [[hi NvimTreeRootFolder guifg=#b5bfe2]]
