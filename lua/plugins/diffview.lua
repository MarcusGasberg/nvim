local u = require("functions.utils")
local diffview = require("diffview")

return {
	copy_hash_and_open = function()
		diffview.trigger_event("copy_hash")
		local global_register = u.get_register(u.get_os() == "Linux" and "+" or "*")
		diffview.trigger_event("goto_file_tab")
		local file_name = vim.fn.expand("%")
		vim.cmd(":Gedit " .. global_register .. ":%")
		vim.cmd(":vert diffsplit " .. file_name)
	end,
	setup = function()
		local cb = require("diffview.config").diffview_callback

		local go_to_git_file = function()
			return ':lua require("plugins.diffview").copy_hash_and_open()<CR>'
		end

		vim.keymap.set("n", "<leader>dfh", ":DiffviewFileHistory<CR>")
		vim.keymap.set("n", "<leader>dfo", ":DiffviewOpen<CR>")
		vim.keymap.set("n", "<leader>dfc", ":DiffviewClose<CR>")

		diffview.setup()
	end,
}
