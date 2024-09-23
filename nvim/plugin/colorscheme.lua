local augrp = vim.api.nvim_create_augroup("PjlColorScheme", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
    desc = "Write colorscheme to file for terminal theme sync",
    group = augrp,
    callback = function(args)
        local colorscheme = args.match
        if not colorscheme then return end
        os.execute("source ~/.zsh/functions/theme && theme " .. colorscheme)
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
