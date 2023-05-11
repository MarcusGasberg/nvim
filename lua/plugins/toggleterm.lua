require("toggleterm").setup{
    shade_terminals=false,
}

local opts= {noremap = true, silent = true}

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "curved",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("normal 0")
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", opts)
  end
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.keymap.set({"n", "t", "i"}, "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", opts)

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<C-j><C-k>', [[<C-\><C-n>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

vim.cmd('autocmd!  TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>')
vim.cmd('nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>')
