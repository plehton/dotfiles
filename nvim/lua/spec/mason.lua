local M = {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    }

}

M.config = function()

    local servers = {
        'lua_ls',
        'pyright',
        'terraformls',
    }

    require("mason").setup {
        ui = {
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }

    require('mason-lspconfig').setup {
        ensure_installed = servers
    }
end

return M
