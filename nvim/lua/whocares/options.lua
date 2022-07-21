local options = {
	backup = false,
	swapfile = false,
	undofile = true,
	clipboard = "unnamedplus",
	ignorecase = true,
	smartcase = true,
	smartindent = true,
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	number = true,
	signcolumn = "yes",
	updatetime = 300,
	scrolloff = 10,
	sidescrolloff = 10,
	wrap = false,
	foldmethod = "indent",
	foldenable = false,
	foldexpr = "nvim_treesitter#foldexpr()",
	incsearch = true,
	termguicolors = true,
	mouse = "a",
	cursorline = true,
}
for k, v in pairs(options) do
	vim.opt[k] = v
end
