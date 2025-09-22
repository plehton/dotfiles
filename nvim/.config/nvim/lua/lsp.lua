local icons = require('pjl.icons')

local servers = {
    'luals',
    'pyright',
    'terraformls',
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- -- autocompletion
        -- if client:supports_method('textDocument/completion') then
        --     vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'nosort', 'fuzzy', 'popup' }
        --     vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        --     vim.keymap.set('i', '<C-Space>', function()
        --         vim.lsp.completion.get()
        --     end)
        -- end

        -- folding
        -- exclude scala, since metals supports folding but fails to do
        -- so with lsp folding
        if client:supports_method('textDocument/foldingRange') and vim.bo.ft ~= 'scala' then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end

        -- format on save
        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.format({ async = false, id = ev.data.client_id })
                end
            })
        end
    end
})

vim.diagnostic.config({

    underline = false,
    severity_sort = true,

    virtual_text = {
        current_line = true,
        virt_text_win_col = vim.o.textwidth - 4,
    },
    float = {
        source = "always",
        border = "single",
        header = "",
        prefix = "",
    },
    signs = {
        active = true,

        text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN]  = icons.diagnostics.Warning,
            [vim.diagnostic.severity.INFO]  = icons.diagnostics.Information,
            [vim.diagnostic.severity.HINT]  = icons.diagnostics.Hint,
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN]  = "WarningMsg",
            [vim.diagnostic.severity.INFO]  = "InformationMsg",
            [vim.diagnostic.severity.HINT]  = "HintMsg",
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = "HintMsg",
            [vim.diagnostic.severity.WARN]  = "HintMsg",
            [vim.diagnostic.severity.INFO]  = "HintMsg",
            [vim.diagnostic.severity.HINT]  = "HintMsg",
        },
    }
})
