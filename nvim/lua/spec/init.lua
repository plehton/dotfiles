--
-- Plugins that won't need any special configuration / setup
--
return {
    "nvim-lua/plenary.nvim",
    "christoomey/vim-tmux-navigator",
    { "godlygeek/tabular", lazy = true },
    { "nvim-tree/nvim-tree.lua",
        enabled = false,
        config = true
    },
    { "justinmk/vim-dirvish", name = "dirvish" },
    "tpope/vim-commentary",
    "romainl/vim-cool",
}
