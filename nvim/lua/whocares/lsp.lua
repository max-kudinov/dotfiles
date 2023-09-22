-- Setup LSP

require("mason").setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup()

local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "M", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<S-j>", vim.diagnostic.goto_next, bufopts)
	vim.keymap.set("n", "<S-k>", vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set("n", " r", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", " F", function()
		vim.lsp.buf.format({
			bufnr = bufnr,
			filter = function(client)
				return client.name == "null-ls"
			end,
		})
	end, bufopts)
	-- Highlight symbol under cursor
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd([[
		hi! lspreferenceread cterm=bold ctermbg=red guibg=#51576d	
		hi! LspReferenceText cterm=bold ctermbg=red guibg=#51576d	
		hi! LspReferenceWrite cterm=bold ctermbg=red guibg=#51576d	
	  ]])
		vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = false,
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = "lsp_document_highlight",
		})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
	-- Disable pyright diagnostics
	if client.name == "pyright" then
		vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
	end
end

-- Add borders
local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}

vim.cmd([[hi normalfloat guibg=none]])
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Change diagnostic symbols
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Servers setup
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

lspconfig.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.csharp_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Null-ls setup
local formatting = require("null-ls").builtins.formatting
local diagnostics = require("null-ls").builtins.diagnostics

require("null-ls").setup({
	sources = {
		formatting.stylua,
        formatting.csharpier,
		formatting.black,
		diagnostics.flake8.with({ extra_args = {"--max-line-length", 88}}),
        -- diagnostics.ruff,
        -- diagnostics.mypy,
	},
})
