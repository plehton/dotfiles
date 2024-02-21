local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)

    vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']e', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>eq', vim.diagnostic.setqflist, opts)
    vim.keymap.set('n', '<leader>el', vim.diagnostic.setloclist, opts)

    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
    vim.keymap.set('v', '<leader>f', vim.lsp.buf.format, opts)
end

local common_capabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    }

    -- required by UFO
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }

    return capabilities
end

-- LSP configuration
--
local lsp = {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/nvim-cmp',
    },
    opts = { inlay_hints = { enabled = true } }
}

lsp.config = function()
    require('neodev').setup()

    local lspconfig = require('lspconfig')
    local icons = require('pjl.icons')

    local servers = {
        'jsonls',
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

        lspconfig[server].setup(opts)
    end
end


-- Scala/Metals configuration
--
local metals = {
    "scalameta/nvim-metals",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

metals.opts = function()
    local metals_config = require("metals").bare_config()

    metals_config = {
        init_options = {
            statusBarProvider = "off"
        },
        settings = {
            showImplicitArguments = true,
            excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
        },
        capabilities = common_capabilities(),
        on_attach = on_attach
    }

    return metals_config
end

---@diagnostic disable-next-line: unused-local
metals.config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "java", "sc" },
        callback = function()
            require("metals").initialize_or_attach(metals_config)

            vim.keymap.set('n', '<leader>sc', function()
                require('metals').hover_worksheet()
            end)
        end,
        group = nvim_metals_group,
    })
end

return { lsp, metals }
