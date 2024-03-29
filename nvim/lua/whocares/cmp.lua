-- Icons for different kinds of stuff
local kind_icons = {
	Text = "󰊄",
	Method = "",
	Function = "󰡱",
	Constructor = "",
	Field = "",
	Variable = "󰫧",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

-- Menu colors
vim.cmd("highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#51576d")
vim.cmd("highlight! CmpItemAbbrMatch guibg=NONE guifg=#ca9ee6")
vim.cmd("highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#ca9ee6")
vim.cmd("highlight! CmpItemKindVariable guibg=NONE guifg=#babbf1")
vim.cmd("highlight! CmpItemKindInterface guibg=NONE guifg=#babbf1")
vim.cmd("highlight! CmpItemKindText guibg=NONE guifg=#babbf1")
vim.cmd("highlight! CmpItemKindFunction guibg=NONE guifg=#ea999c")
vim.cmd("highlight! CmpItemKindMethod guibg=NONE guifg=#ea999c")
vim.cmd("highlight! CmpItemKindKeyword guibg=NONE guifg=#c6d0f5")
vim.cmd("highlight! CmpItemKindProperty guibg=NONE guifg=#c6d0f5")
vim.cmd("highlight! CmpItemKindUnit guibg=NONE guifg=#c6d0f5")

local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip/loaders/from_vscode").lazy_load()

-- No idea what this function does, but has something to do with Super-Tab
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = false }),

		-- Super-Tab
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),

	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			vim_item.menu = ({
				nvim_lsp = "LSP",
				luasnip = "Snippet",
				buffer = "Buffer",
				path = "Path",
			})[entry.source.name]
			return vim_item
		end,
	},

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
})

-- Autopairs functionality

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
