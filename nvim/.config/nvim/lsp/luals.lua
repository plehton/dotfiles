local l = require('lush')

return {
    foom,
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    var,
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
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
