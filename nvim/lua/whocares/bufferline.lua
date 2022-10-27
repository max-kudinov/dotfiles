-- Settings for bufferline

require("bufferline").setup({
    highlights = {
        fill = {
            bg = "#232634",
            fg = "#232634",
        },
        separator_selected = {
            fg = "#232634",
        },
        separator_visible = {
            fg = "#232634",
        },
        separator = {
            fg = "#232634",
        },
    },
	options = {
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = " "
			for e in pairs(diagnostics_dict) do
				local sym = e == "error" and "" or (e == "warning" and "" or "")
				s = s .. sym
			end
			return s
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
		indicator = {
			style = 'icon',
			icon = '  ',
		},
		separator_style = "slant",
	},
})
