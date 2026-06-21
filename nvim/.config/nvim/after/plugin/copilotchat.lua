vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CopilotChatToggle<cr>", { desc = "Copilot Chat - Toggle" })
vim.keymap.set("v", "<leader>ce", "<cmd>CopilotChatExplain<cr>", { desc = "Copilot Chat - Explain Code" })
vim.keymap.set("v", "<leader>cf", "<cmd>CopilotChatFix<cr>", { desc = "Copilot Chat - Fix Diagnostic" })