require("lualine").setup({
	options = {
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		-- theme = "kanagawa",
		theme = "tokyonight",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "diff", "diagnostics" },
		lualine_d = {
			{
				"filetype",
				colored = true, -- Displays filetype icon in color if set to true
				icon_only = true, -- Display only an icon for filetype
			},
			{
				"filename",
				file_status = true,
				path = 1,
				symbols = {
					modified = "  ", -- Text to show when the file is modified.
					readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
				},
			},
		},
		lualine_w = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { 'fugitive' }
})
