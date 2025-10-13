local icons = require('pjl.icons')

vim.lsp.enable({ 'lua_ls', 'pyright', 'terraformls' })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        assert(client ~= nil)

        if client:supports_method('textDocument/completion') then
            vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'nosort', 'fuzzy', 'popup' }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end

        -- if client:supports_method('textDocument/foldingRange') then
        --     local win = vim.api.nvim_get_current_win()
        --     vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        -- end

        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('pjl-lsp-settings', { clear = false }),
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end
})

vim.diagnostic.config({
    underline = true,
    severity_sort = { reverse = true },
    virtual_lines = { current_line = true },
    -- virtual_text = { current_line = false },
    -- jump = { float = { scope = "cursor" } },
    float = {
        source = true,
        border = "rounded",
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
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN]  = "WarningMsg",
            [vim.diagnostic.severity.INFO]  = "InformationMsg",
            [vim.diagnostic.severity.HINT]  = "HintMsg",
        },
    }
})
