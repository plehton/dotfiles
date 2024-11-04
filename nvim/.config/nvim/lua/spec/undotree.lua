local M = {
    'mbbill/undotree',
    lazy = true,
    dependencies = "nvim-lua/plenary.nvim",
    init = function ()
        vim.g.undotree_WindowLayout = 1
        vim.g.undotree_SplitWidth = 30
        vim.g.undotree_ShortIndicators = 1
        vim.g.undotree_DiffAutoOpen = 0
        vim.g.undotree_SetFocusWhenToggle = 1
    end,
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
    },
}

return M
