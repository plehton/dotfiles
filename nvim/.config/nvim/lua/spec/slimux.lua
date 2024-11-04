return {
    { "epeli/slimux",
        lazy = true,
        config = function()
            vim.keymap.set("n", "<leader>sl", vim.cmd("SlimuxREPLSendLine"))
            vim.keymap.set("n", "<leader>sp", vim.cmd("SlimuxREPLSendParagraph"))
            vim.keymap.set("n", "<leader>sb", vim.cmd("SlimuxREPLSendBuffer"))
            vim.keymap.set("n", "<leader>sc", vim.cmd("SlimuxREPLConfigure"))
        end
    },
}
