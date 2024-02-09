--  ex mode without shift
vim.keymap.set("n", ",", ":")

-- double leader changes to alternate file 
vim.keymap.set("n", "<leader><leader>", "<C-^>")

vim.keymap.set("n", "<leader>o", ":only<CR>")

-- Open/Close folds with Tab
vim.keymap.set("n", "<Tab>", "za")

-- Relying on Karabiner-Elements (macOS) or Interception Tools (Linux) to avoid
-- collision between <Tab> and <C-i> (have it send F6 instead for <C-i>).
-- source: Greg Hurrell
vim.keymap.set("n", "<F6>", "<C-i>")

-- Arrows mapped to quicklist
vim.keymap.set("n", "<silent><Up>", ":cprevious<CR>")
vim.keymap.set("n", "<silent><Down>", ":cnext<CR>")
vim.keymap.set("n", "<silent><Left>", ":cpfile<CR>")
vim.keymap.set("n", "<silent><Right>", ":cnfile<CR>")

-- fugitive
vim.keymap.set("n", "<leader>g", ":G<CR>")
vim.keymap.set("n", "<leader>ge", ":Ge:<CR>")
