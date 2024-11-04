P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function (...)
    return require('plenary.reload').reload_module(...)
end

R = function(m)
    RELOAD(m)
    return require(m)
end

vim.keymap.set("n", "<leader>xx", function() vim.cmd.source("%") end)

vim.keymap.set("n", "<leader>xr", function()
    local m = vim.fn.expand("%:t:r")
    print("Reloading '" .. m .. "'")
    R(m)
end)

