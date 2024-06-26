local startup_ok, startup = pcall(require, "startup")

if not startup_ok then
	print("Startup not installed")
	return
end

local settings = {
    -- every line should be same width without escaped \
    header = {
        type = "text",
        align = "center",
        fold_section = false,
        title = "Header",
        margin = 5,
        content = require("startup.headers").hydra_header,
        highlight = "Statement",
        default_color = "",
        oldfiles_amount = 0,
    },
    header_2 = {
        type = "text",
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Quote",
        margin = 5,
        content = require("startup.functions").quote(),
        highlight = "Constant",
        default_color = "",
        oldfiles_amount = 0,
    },
    -- name which will be displayed and command
    body = {
        type = "mapping",
        align = "center",
        fold_section = true,
        title = "Basic Commands",
        margin = 5,
        content = {
            { " Find File", "Telescope find_files", "<leader>j" },
            { " Find Word", "Telescope live_grep", "<leader>h" },
            { " Recent Files", "Telescope oldfiles", "<leader>of" },
            { " File Browser", "NeoTreeFocusToggle", "\\" },
            { " Colorschemes", "Telescope colorscheme", "<leader>cs" },
            { " New File", "lua require'startup'.new_file()", "<leader>nf" },
        },
        highlight = "String",
        default_color = "",
        oldfiles_amount = 0,
    },
    body_2 = {
        type = "oldfiles",
        oldfiles_directory = true,
        align = "center",
        fold_section = true,
        title = "Oldfiles of Directory",
        margin = 5,
        content = {},
        highlight = "String",
        default_color = "#FFFFFF",
        oldfiles_amount = 5,
    },
    footer = {
        type = "oldfiles",
        oldfiles_directory = false,
        align = "center",
        fold_section = true,
        title = "Oldfiles",
        margin = 5,
        content = { "startup.nvim" },
        highlight = "TSString",
        default_color = "#FFFFFF",
        oldfiles_amount = 5,
    },

    clock = {
        type = "text",
        content = require("startup.functions").date_time,
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "",
        margin = 5,
        highlight = "TSString",
        default_color = "#FFFFFF",
        oldfiles_amount = 10,
    },

    -- footer_2 = {
    --     type = "text",
    --     content = require("startup.functions").packer_plugins,
    --     oldfiles_directory = false,
    --     align = "center",
    --     fold_section = false,
    --     title = "",
    --     margin = 5,
    --     highlight = "TSString",
    --     default_color = "#FFFFFF",
    --     oldfiles_amount = 10,
    -- },
    options = {
        mapping_keys = true,
        cursor_column = 0.5,
        empty_lines_between_mappings = true,
        disable_statuslines = true,
        paddings = { 2, 2, 2, 2, 2, 2, 2 },
    },
    colors = {
        background = "#1f2227",
        folded_section = "#56b6c2",
    },
    parts = {
        "header",
        "header_2",
        "body",
        "body_2",
        "footer",
        "clock",
    },
}

startup.setup(settings)

