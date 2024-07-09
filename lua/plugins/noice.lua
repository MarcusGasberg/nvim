local views = {
	mini = {
		border = {
			style = "rounded",
			padding = { 0, 2 },
		},
		win_options = {
			winblend = 0,
		},
		position = {
			row = 0,
			col = "100%",
		},
	},
}

require("noice").setup({
	views = views,
	messages = {
		enabled = true,
	},
	lsp = {
		progress = {
			enabled = false,
		},
		hover = {
			enabled = false,
		},
		signature = {
			enabled = false,
		},
		message = {
			enabled = true,
		},
	},
	routes = {
		{
			filter = {
				event = "msg_show",
				kind = "",
			},
			opts = { skip = true },
		},
	},
})
