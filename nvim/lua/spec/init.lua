--
-- Plugins that won't need any special configuration / setup
--
return {
    "nvim-lua/plenary.nvim",
    { 'folke/neodev.nvim',
       lazy = true,
       opts = {
            library = {
                plugins = { "neotest" },
                types = true
            }
        }
    },
    "christoomey/vim-tmux-navigator",
    { "godlygeek/tabular", cmd = "Tab" },
    { "nvim-tree/nvim-tree.lua",
        enabled = false,
        config = true
    },
    { "justinmk/vim-dirvish", name = "dirvish" },
    "tpope/vim-commentary",
    "romainl/vim-cool",
}
