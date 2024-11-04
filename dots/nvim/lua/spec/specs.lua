--
-- Plugins that won't need any special configuration / setup
--
return {
    "nvim-lua/plenary.nvim",
    { 'folke/neodev.nvim',
       lazy = true,
    },
    "christoomey/vim-tmux-navigator",
    { "godlygeek/tabular", cmd = "Tab" },
    { "justinmk/vim-dirvish", name = "dirvish" },
    "tpope/vim-commentary",
    "romainl/vim-cool",
}
