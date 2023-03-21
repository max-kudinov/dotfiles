-- Automatically clean, update, install plugins and
-- recompile when this file has been changed.
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

local packer = require("packer")

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install plugins
return packer.startup(function(use)
	-- Things for plugin functioning
	use("wbthomason/packer.nvim")
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")

	-- Themes
	use({ "catppuccin/nvim", as = "catppuccin" })
	-- use "morhetz/gruvbox"
	-- use "dracula/vim"
	-- use "folke/tokyonight.nvim"

	-- Completions & snippets
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
	use("hrsh7th/cmp-nvim-lsp")
	use("jose-elias-alvarez/null-ls.nvim")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("p00f/nvim-ts-rainbow")

	-- Minor useful stuff
	use("windwp/nvim-autopairs") -- autopairs for quotes, brackets etc
	use{
		"numToStr/Comment.nvim", -- comments
		config = function()
			require("Comment").setup()
		end,
	}
    use("mrjones2014/smart-splits.nvim") -- better split resizing and navigation
	use("lewis6991/gitsigns.nvim") -- git integration
	use("kyazdani42/nvim-web-devicons") -- icons
	use("kyazdani42/nvim-tree.lua") -- file explorer
	use("akinsho/bufferline.nvim") -- tabs on top
	use("lukas-reineke/indent-blankline.nvim") -- identation guides
	use("nvim-lualine/lualine.nvim") -- statusline
    use("andweeb/presence.nvim") -- Discord activity
end)
