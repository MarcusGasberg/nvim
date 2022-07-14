local fTerm = require("FTerm")
fTerm.setup({
  cmd = "powershell"
})
vim.keymap.set("n", "<C-z>", fTerm.toggle, {})
vim.keymap.set("t", "<C-z>", '<C-\\><C-n>:lua require("FTerm").toggle()<CR>')
