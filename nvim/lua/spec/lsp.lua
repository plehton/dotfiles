local lsp_keymaps = function(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap

    keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    keymap(bufnr, 'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    keymap(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

    keymap(bufnr, 'n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    keymap(bufnr, 'n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    keymap(bufnr, 'n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    keymap(bufnr, 'n', 'gee', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
end

local on_attach = function(_, bufnr)
    lsp_keymaps(bufnr)
end

local common_capabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return capabilities
end

local lsp = {
    'neovim/nvim-lspconfig',
    -- event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'folke/neodev.nvim',
    },
}

lsp.config = function()
    local lspconfig = require('lspconfig')
    -- local icons = require('nvim-web-devicons')

    local servers = {
        'lua_ls',
        'pyright',
        'terraformls',
    }

    local diagnostic_config = {
        signs = {
            active = true,
            values = {
                { name = "DiagnosticSignError", text = 'E' },
                { name = "DiagnosticSignWarn",  text = 'W' },
                { name = "DiagnosticSignHint",  text = '!' },
                { name = "DiagnosticSignInfo",  text = 'I' },
            },
        },
        underline = true,
        virtual_text = false,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(diagnostic_config)

    for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end

    for _, server in pairs(servers) do
        local opts = {
            on_attach = on_attach,
            capabilities = common_capabilities(),
        }

        local require_ok, settings = pcall(require, "spec.lspsettings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
        end

        if server == "lua_ls" then
            require("neodev").setup {}
        end

        lspconfig[server].setup(opts)
    end
end

local metals = {
    "scalameta/nvim-metals",
    ft = 'scala',
    dependencies = { "nvim-lua/plenary.nvim" }
}

metals.opts = function()
    local metals_config = require("metals").bare_config()

    metals_config = {
        settings = {
            showImplicitArguments = true,
            excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
        },
        capabilities = common_capabilities(),
        on_attach = on_attach
    }
    return metals_config
end

metals.config = function(_, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "java" },
        callback = function()
            require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
    })
end

return { lsp, metals }
