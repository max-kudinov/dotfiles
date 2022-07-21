-- Setup LSP

require("nvim-lsp-installer").setup({
	ui = {
		border = "rounded",
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		}
	}
})

local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<A-j>", vim.diagnostic.goto_next, bufopts)
	vim.keymap.set("n", "<A-k>", vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set("n", " r", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", " F", vim.lsp.buf.formatting, bufopts)
	-- Highlight symbol under cursor
	if client.resolved_capabilities.document_highlight then
	  vim.cmd [[
		hi! lspreferenceread cterm=bold ctermbg=red guibg=#414559	
		hi! LspReferenceText cterm=bold ctermbg=red guibg=#414559	
		hi! LspReferenceWrite cterm=bold ctermbg=red guibg=#414559	
	  ]]
	  vim.api.nvim_create_augroup("lsp_document_highlight", {
		clear = false
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
end

-- Add borders
local border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
}

vim.cmd [[hi normalfloat guibg=none]]
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
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Servers setup
lspconfig.sumneko_lua.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { Lua = { diagnostics = { globals = { "vim" } } } }
}

lspconfig.pyright.setup {
	capabilities = capabilities,
	on_attach = on_attach,
}

-- Null-ls setup
local formatting = require"null-ls".builtins.formatting
local diagnostics = require"null-ls".builtins.diagnostics

require"null-ls".setup({
	sources = {
		formatting.stylua,
		formatting.black,
		diagnostics.flake8,
	}
})
