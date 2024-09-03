return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
    },
    {
        "catppuccin/nvim",
        name = 'catppuccin',
        lazy = false,
        priority = 1000,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        opts = {
        },
        config = function()
            vim.g.everforest_background = 'hard'
        end
    },
    {
        "jacoborus/tender",
        lazy = false,
        priority = 1000,
        opts = {
        },
        config = function()
            vim.g.everforest_background = 'hard'
        end
    },
    {
        "shaunsingh/nord.nvim",
        lazy = false,
        config = function()
            -- Example config in lua
            vim.g.nord_contrast = true
            vim.g.nord_borders = true
            vim.g.nord_disable_background = false
            vim.g.nord_italic = true
            vim.g.nord_uniform_diff_background = true
            vim.g.nord_bold = false
            -- Load the colorscheme
            -- require('nord').set()
        end
    },
    {
        "savq/melange-nvim",
        name = "melange",
        lazy = false,
        priority = 1000,
    }
}
