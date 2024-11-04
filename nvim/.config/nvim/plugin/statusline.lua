-- set statusline to active status
require('pjl.statusline').active()

local augrp = vim.api.nvim_create_augroup("PjlStatusLine", { clear = true })

vim.api.nvim_create_autocmd(
    { "BufWinEnter", "BufModifiedSet", "WinEnter", "FocusGained"},
    -- {"BufWinEnter", "BufModifiedSet", "TextChanged", "TextChangedI", "WinEnter", "FocusGained"},
    {
        desc = "Update modified / lhs of statusline",
        group = augrp,
        callback = function()
            require('pjl.statusline').active()
            require('pjl.statusline').check_modified()
        end
    })

vim.api.nvim_create_autocmd(
    { "WinLeave", "FocusLost" },
    {
        desc = "Update modified / lhs of statusline",
        group = augrp,
        callback = function()
            require('pjl.statusline').inactive()
        end
    })

