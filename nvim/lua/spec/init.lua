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
    "tpope/vim-fugitive",
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "tpope/vim-unimpaired",
    "romainl/vim-cool",
}
