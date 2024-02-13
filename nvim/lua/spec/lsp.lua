local lsp_keymaps = function(bufnr)

    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd',vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr',vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>dq',vim.diagnostic.setqflist, opts)

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
    local icons = require('pjl.icons')

    local servers = {
        'lua_ls',
        'pyright',
        'terraformls',
    }

    local diagnostic_config = {
        signs = {
            active = true,
            values = {
                { name = "DiagnosticSignError", text = icons.diagnostics.Error },
                { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
                { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
                { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
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
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- ft = { "scala", "sbt", "java", "sc" },
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
        pattern = { "scala", "sbt", "java", "sc" },
        callback = function()
            require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
    })
end

return { lsp, metals }
