return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "zbirenbaum/copilot.lua" },
        { "nvim-lua/plenary.nvim" },
    },
    opts = {
        show_help = "yes", -- Show help text at the top of the chat window
    },
    keys = {
        { "<leader>cc", "<cmd>CopilotChatToggle<cr>",  desc = "Copilot Chat - Toggle" },
        { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Copilot Chat - Explain Code",   mode = "v" },
        { "<leader>cf", "<cmd>CopilotChatFix<cr>",     desc = "Copilot Chat - Fix Diagnostic", mode = "v" },
    },
}
