return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            format = {
                enable = true,
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library",
                    vim.fn.stdpath("data") .. "/lazy/",
                    -- vim.fn.stdpath("config"),
                }

            },
            diagnostics = {
                globals = { "vim" },
                disable = { "missing-parameter", "missing-fields" }
            },
        },
    },
}
