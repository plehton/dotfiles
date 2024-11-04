--  ex mode without shift
vim.keymap.set("n", ",", ":")

-- close all other splits
vim.keymap.set("n", "<leader>o", ":only<CR>")

-- Relying on Karabiner-Elements (macOS) or Interception Tools (Linux) to avoid
-- collision between <Tab> and <C-i> (have it send F6 instead for <C-i>).
-- source: Greg Hurrell
vim.keymap.set("n", "<F6>", "<C-i>")

-- Tab open/closes one or all folds
vim.keymap.set("n", "<Tab>", "za")
vim.keymap.set("n", "<S-Tab>", "zA")

-- Arrows mapped to quicklist
vim.keymap.set("n", "<Up>", ":cprevious<CR>", { silent = true })
vim.keymap.set("n", "<Down>", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "<Left>", ":cpfile<CR>", { silent = true })
vim.keymap.set("n", "<Right>", ":cnfile<CR>", { silent = true })
