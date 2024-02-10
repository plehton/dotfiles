--  ex mode without shift
vim.keymap.set("n", ",", ":")

-- close all other splits
vim.keymap.set("n", "<leader>o", ":only<CR>")

-- Relying on Karabiner-Elements (macOS) or Interception Tools (Linux) to avoid
-- collision between <Tab> and <C-i> (have it send F6 instead for <C-i>).
-- source: Greg Hurrell
vim.keymap.set("n", "<F6>", "<C-i>")

-- Arrows mapped to quicklist
vim.keymap.set("n", "<silent><Up>", ":cprevious<CR>")
vim.keymap.set("n", "<silent><Down>", ":cnext<CR>")
vim.keymap.set("n", "<silent><Left>", ":cpfile<CR>")
vim.keymap.set("n", "<silent><Right>", ":cnfile<CR>")
