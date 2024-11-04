require("pjl.colors").sync_colorscheme(true)
require("pjl.colors").colorize()

local augrp = vim.api.nvim_create_augroup("PjlColorScheme", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
    desc = "Write selected colorscheme to ~/.colorscheme",
    group = augrp,
    callback = function(args)
        local colorscheme = args.match
        if colorscheme and colorscheme ~= vim.g.colors_name then
            os.execute("source ~/.zsh/functions/theme && theme " .. colorscheme)
        end
    end
})

vim.api.nvim_create_autocmd("FocusGained", {
    desc = "Set colorscheme from .colorscheme",
    group = augrp,
    callback = function()
            require("pjl.colors").sync_colorscheme()
            require("pjl.colors").colorize()
    end,
})

vim.api.nvim_create_autocmd({ "SourcePost" }, {
    desc = "Customizes colorscheme when it is changed",
    pattern = "*/colors/*",
    group = augrp,
    callback = function()
        require('pjl.colors').colorize()
        require('pjl.statusline').update_highlights()
    end
})
