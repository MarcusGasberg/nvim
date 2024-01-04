local harpoon = require("harpoon")
local utils = require("telescope.utils")
local action_state = require("telescope.actions.state")
local action_utils = require("telescope.actions.utils")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

harpoon:setup({
	settings = {
		sync_on_ui_close = true,
	},
})

vim.keymap.set("n", "<leader>h", function()
	harpoon:list():append()
end)

local generate_new_finder = function()
	return finders.new_table({
		results = harpoon:list().items,
		entry_maker = function(entry)
			local display = function(displayEntry)
				local display_string = "%s - %s%s"

				local coordinates = ":"
				if entry.context.row then
					if entry.context.col then
						coordinates = string.format(":%s:%s", entry.context.row, entry.context.col)
					else
						coordinates = string.format(":%s", entry.context.row)
					end
				end

				local display, hl_group, icon = utils.transform_devicons(
					displayEntry.filename,
					string.format(display_string, displayEntry.index, entry.value, coordinates),
					false
				)

				if hl_group then
					return display, { { { 0, #icon }, hl_group } }
				else
					return display
				end
			end
			return {
				value = entry,
				ordinal = entry.value,
				display = display,
				lnum = entry.row,
				col = entry.col,
				filename = entry.value,
			}
		end,
	})
end

local delete_harpoon_mark = function(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	harpoon:list():remove(selection.value)

	local function get_selections()
		local results = {}
		action_utils.map_selections(prompt_bufnr, function(entry)
			table.insert(results, entry)
		end)
		return results
	end

	local selections = get_selections()
	for _, current_selection in ipairs(selections) do
		harpoon:list():remove(current_selection.value)
	end

	local current_picker = action_state.get_current_picker(prompt_bufnr)
	current_picker:refresh(generate_new_finder(), { reset_prompt = true })
end

local move_mark_up = function(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	local length = harpoon:list():length()

	if selection.index == length then
		return
	end

	local mark_list = harpoon:list().items

	table.remove(mark_list, selection.index)
	table.insert(mark_list, selection.index + 1, selection.value)

	local current_picker = action_state.get_current_picker(prompt_bufnr)
	current_picker:refresh(generate_new_finder(), { reset_prompt = true })
end

local move_mark_down = function(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	if selection.index == 1 then
		return
	end
	local mark_list = harpoon:list().items
	table.remove(mark_list, selection.index)
	table.insert(mark_list, selection.index - 1, selection.value)
	local current_picker = action_state.get_current_picker(prompt_bufnr)
	current_picker:refresh(generate_new_finder(), { reset_prompt = true })
end

local function toggle_telescope()
	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = generate_new_finder(),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(_, map)
				map("i", "<c-x>", delete_harpoon_mark)
				map("n", "<c-x>", delete_harpoon_mark)

				map("i", "<c-k>", move_mark_up)
				map("n", "<c-k>", move_mark_up)

				map("i", "<c-j>", move_mark_down)
				map("n", "<c-j>", move_mark_down)
				return true
			end,
		})
		:find()
end

vim.keymap.set("n", "<leader>l", function()
	toggle_telescope()
end, { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>1", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>2", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>3", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>4", function()
	harpoon:list():select(4)
end)
