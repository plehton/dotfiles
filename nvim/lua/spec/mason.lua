local M = {
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        config = function()
            require('mason').setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require('mason-lspconfig').setup {}
        end
    }
}

return M
