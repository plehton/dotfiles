local opts = require("metals").bare_config()
opts.init_options.statusBarProvider = "off"

local nvim_metals_group = vim.api.nvim_create_augroup("pjl-nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "java" },
    callback = function()
        require("metals").initialize_or_attach(opts)
    end,
    group = nvim_metals_group,
})