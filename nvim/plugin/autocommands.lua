local augrp = vim.api.nvim_create_augroup("pjl", { clear = true })

vim.api.nvim_create_autocmd({"BufRead"},{
    desc = "Turn on vim modelines for any file inside dotfiles",
    pattern = "**/dotfiles/**",
    group = augrp,
    callback = function()
        vim.o.modelines=2
    end
})

vim.api.nvim_create_autocmd({"BufRead"},{
    desc = "Set all ftype=zsh to all files in dotfiles/zsh",
    pattern = "**/dotfiles/zsh/**",
    group = augrp,
    callback = function()
        vim.o.filetype="sh"
    end
})

vim.api.nvim_create_autocmd({"FileType"},{
    desc = "Enable treesitter folding in source code",
    pattern = { "scala", "python", "lua", "terraform" },
    group = augrp,
    callback = function()
        vim.wo.foldexpr="nvim_treesitter#foldexpr()"
    end
})

vim.api.nvim_create_autocmd({"TextYankPost"},{
    desc = "Highlights yanked text",
    group = augrp,
    callback = function()
        vim.highlight.on_yank { higroup='IncSearch', timeout=400 }
    end
})

vim.api.nvim_create_autocmd({"FileType"},{
    desc = "Map gq in normal mode to close quicklist and help windows",
    pattern = {"qf", "help"},
    group = augrp,
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "gq", ":q<CR>", { noremap = true, silent = true})
    end
})

vim.api.nvim_create_autocmd({"BufRead"},{
    desc = "Opens the configuration file for table under cursor",
    pattern = "**scaliber/configurations/raw/*.yml",
    group = augrp,
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', '<C-]>',
            ":lua require('pjl.scaliber').open_table_config()<CR>",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, 'n', 'gd',
            ":lua require('pjl.scaliber').open_table_config()<CR>",
            { noremap = true, silent = true })
    end
})

vim.api.nvim_create_autocmd({"BufRead"},{
    desc = "Opens scaliber raw configurations which refer to this table configuration",
    pattern = "**scaliber/configurations/table/*.yml",
    group = augrp,
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', 'gr',
            (":lua require('pjl.scaliber').open_table_references()<CR>"),
            { noremap = true, silent = true })
    end
})

vim.api.nvim_create_autocmd({"FocusGained", "ColorScheme", "BufWinEnter", "BufModifiedSet"},{
    desc = "Updates colorscheme when Vim gets focus or when colorscheme is changed",
    group = augrp,
    callback = function()
        local c = require('pjl.colors')
        -- set colorscheme from ~/.theme
        c.colorscheme()
        -- 
        c.Customize(3)
        require'pjl.statusline'.check_modified()
    end
})

vim.api.nvim_create_autocmd({"VimResized"},{
    desc = "Resize vim windows when terminal window is resized",
    group = augrp,
    command = "wincmd ="
})

vim.api.nvim_create_autocmd({"BufWritePre"},{
    desc = "Remove trailing whitespace",
    group = augrp,
    command = "%s/\\s\\+$//e"
})
