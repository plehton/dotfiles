-- Autocommands {{{

local augrp = vim.api.nvim_create_augroup("pjl-autocommands", { clear = true })

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augrp,
    pattern = '*',
    callback = function()
        vim.hl.on_yank({ higroup = 'Visual', timeout = 400 })
    end
})

-- }}}
