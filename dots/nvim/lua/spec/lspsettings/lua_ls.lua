return {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            format = {
                enable = true
            },
            diagnostics = {
                globals = { 'vim' },
                disable = { "missing-parameter", "missing-fields" }
            },
        },
    },
}
