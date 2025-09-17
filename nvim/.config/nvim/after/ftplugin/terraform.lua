local augrp = vim.api.nvim_create_augroup("terraform_ftplugin", { clear = true })

vim.api.nvim_create_autocmd({"BufWritePost"},{
    desc = "Autoformat terraform files using 'terraform fmt'",
    group = augrp,
    callback = function()
        vim.cmd('silent !terraform fmt ' .. vim.fn.expand('%:p'))
    end
})
