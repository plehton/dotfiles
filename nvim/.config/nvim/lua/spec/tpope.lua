return {
        { "tpope/vim-fugitive",
        config = function ()

            vim.keymap.set("n", "<leader>g", ":G<CR>")
            vim.keymap.set("n", "<leader>ge", ":Ge:<CR>")

        end
    },
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "tpope/vim-unimpaired",
}
