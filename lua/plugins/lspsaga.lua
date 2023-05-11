require('lspsaga').setup({
	lightbulb = {
		enable = false
	},
	ui = {
		title = true,
		border = 'rounded',
		winblend = 0,
    expand = "",
    collapse = "",
    code_action = "💡",
    incoming = " ",
    outgoing = " ",
    hover = ' ',
    kind = {},
	}
}) 

local keymap = vim.keymap.set

keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
