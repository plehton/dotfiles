return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = { enabled = false }, -- Disable the bulky separate panel
                suggestion = {
                    enabled = true,
                    auto_trigger = true, -- Start suggesting as you type
                    debounce = 75,
                    keymap = {
                        accept = "<M-l>",      -- Alt + l to accept the whole suggestion
                        accept_word = "<M-w>", -- Alt + w to accept just the next word
                        accept_line = "<M-f>", -- Alt + f to accept just the next line
                        next = "<M-]>",        -- Alt + ] for next option
                        prev = "<M-[>",        -- Alt + [ for previous option
                        dismiss = "<C-]>",     -- Ctrl + ] to hide suggestion
                    },
                },
                filetypes = {
                    yaml = false,
                    markdown = true, -- Enable for markdown files if desired
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    ["."] = false,
                },
            })
        end,
    }
}
