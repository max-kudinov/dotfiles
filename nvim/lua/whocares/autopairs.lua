-- Settings for autopairs

require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt" },
	check_ts = true,
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = [=[[%'%"%)%>%]%)%}%,]]=],
		end_key = ";",
		keys = "hjklqwertyuiopzxcvbnmasdfg",
		check_comma = true,
		highlight = "Search",
		highlight_grey = "Comment",
	},
})
