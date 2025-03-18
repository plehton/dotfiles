return {
    {
        "zenbones-theme/zenbones.nvim",
        -- Optionally install Lush. Allows for more configuration or extending the colorscheme
        -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
        -- In Vim, compat mode is turned on as Lush only works in Neovim.
        dependencies = "rktjmp/lush.nvim",
        lazy = false,
        priority = 1000,
        -- you can set set configuration options here
        -- config = function()
        --     vim.g.zenbones_darken_comments = 45
        --     vim.cmd.colorscheme('zenbones')
        -- end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
    },
    {
        "folke/tokyonight.nvim",
        name = 'tokyonight',
        lazy = false
    },
    {
        "catppuccin/nvim",
        name = 'catppuccin',
        cmd = "Colorscheme",
        lazy = false,
        priority = 1000,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "jacoborus/tender",
        lazy = false,
        priority = 1000,
    },
    {
        "savq/melange-nvim",
        name = "melange",
        lazy = false,
        priority = 1000,
    }
}
