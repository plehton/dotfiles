local augrp = vim.api.nvim_create_augroup("pjl-autocommands", { clear = true })

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augrp,
    pattern = '*',
    callback = function()
        vim.hl.on_yank({ higroup = 'Visual', timeout = 400 })
    end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    desc = "Map gq in normal mode to close quicklist and help windows",
    pattern = { "qf", "help" },
    group = augrp,
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "gq", ":q<CR>", { noremap = true, silent = true })
    end
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
    desc = "Resize vim windows when terminal window is resized",
    group = augrp,
    command = "wincmd ="
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    desc = "Remove trailing whitespace",
    group = augrp,
    command = "%s/\\s\\+$//e"
})
