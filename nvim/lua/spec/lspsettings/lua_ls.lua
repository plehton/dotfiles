return {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            format = {
                enable = false
            },
            diagnostics = {
                -- globals = { 'vim' },
                disable = { "missing-parameters", "missing-fields" }
            },
        },
    },
}
