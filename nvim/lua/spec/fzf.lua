return {
    { "ibhagwan/fzf-lua",
        name = "fzf",
        dependencies = { "devicons" },
        config = function()

            local fzf = require('fzf-lua')

            fzf.setup({})

            vim.keymap.set("n", "<C-p>",      fzf.files)
            vim.keymap.set("n", "<Leader>fb", fzf.buffers)
            vim.keymap.set("n", "<Leader>fm", fzf.oldfiles)
            vim.keymap.set("n", "<Leader>fg", fzf.grep)
            vim.keymap.set("n", "<Leader>fw", fzf.grep_cWORD)
            vim.keymap.set("n", "<Leader>fh", fzf.help_tags)

        end,
    },
}
