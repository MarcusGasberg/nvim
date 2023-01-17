local colors = require("catppuccin.palettes").get_palette "mocha"
require("scrollbar").setup({
	show = true,
	handle = {
		text = " ",
		color = colors.waveBlue1,
		hide_if_all_visible = true, -- Hides handle if all lines are visible
	},
marks = {
        Search = { color = colors.orange },
        Error = { color = colors.error },
        Warn = { color = colors.warning },
        Info = { color = colors.info },
        Hint = { color = colors.hint },
        Misc = { color = colors.purple },
    },
	excluded_filetypes = {
		"",
		"prompt",
		"TelescopePrompt",
	},
	autocmd = {
		render = {
			"BufWinEnter",
			"TabEnter",
			"TermEnter",
			"WinEnter",
			"CmdwinLeave",
			"TextChanged",
			"VimResized",
			"WinScrolled",
		},
	},
	handlers = {
		diagnostic = true,
		search = true,
	},
})


