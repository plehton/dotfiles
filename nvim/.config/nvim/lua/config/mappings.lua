-- use comma for command-mode
vim.keymap.set("n", ",", ":")
vim.keymap.set("v", ",", ":")
vim.keymap.set("x", ",", ":")

-- expand current buffer's directory in command mode
vim.cmd [[ cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%' ]]

vim.keymap.set("n", "<leader>o", "<cmd>only<CR>")
vim.keymap.set("n", "<leader>u", "<cmd>undotree<cr>")

-- moving around in buffer keeps cursor in the middle of the screen
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- yank to system clipboard
vim.keymap.set('n', 'gy', '"+y')
vim.keymap.set('n', 'gyy', '"+yy')

-- put from system clipboard
vim.keymap.set('n', 'gp', '"+p')
