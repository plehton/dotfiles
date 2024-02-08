return {
    { "rose-pine/neovim", name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require('pjl.colors').set_cli_colorscheme()
        end
    },
    { "folke/tokyonight.nvim" },
    { "catppuccin/nvim" },
}
