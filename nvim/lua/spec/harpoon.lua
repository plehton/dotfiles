return {
    'ThePrimeagen/harpoon',
    config = function()
        require("harpoon").setup({

        -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
        save_on_toggle = false,

        -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
        enter_on_sendcmd = false,

        -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
        tmux_autoclose_windows = false,

        -- filetypes that you want to prevent from adding to the harpoon list menu.
        excluded_filetypes = { "harpoon" },

        -- set marks specific to each git branch inside git repository
        mark_branch = false,

        -- projects = {
        --         -- Yes $HOME works
        --         ["$HOME/code/vim-with-me/server"] = {
        --             term = {
        --                 cmds = {
        --                     "./env && npx ts-node src/index.ts"
        --                 }
        --             }
        --         }
        --     },

        })

        vim.keymap.set("n", "<leader>h", require('harpoon.mark').add_file)
        vim.keymap.set("n", "<leader><Tab>", require('harpoon.ui').toggle_quick_menu)
        vim.keymap.set("n", "<Tab>", require('harpoon.ui').nav_next)
        vim.keymap.set("n", "<S-Tab>", require('harpoon.ui').nav_prev)

    end

}
