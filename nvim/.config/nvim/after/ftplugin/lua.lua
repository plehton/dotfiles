local augrp = vim.api.nvim_create_augroup("lua_ftplugin", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0, -- 0 specifies the CURRENT buffer only
    callback = function()
        vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
    end,
    group = augrp,
})
