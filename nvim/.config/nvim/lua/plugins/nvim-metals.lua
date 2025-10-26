return {
    "scalameta/nvim-metals",
    ft = { "scala", "java" },
    opts = function()
        local opts = require("metals").bare_config()
        opts.init_options.statusBarProvider = "off"
        return opts
    end,

    config = function(self, opts)
        local nvim_metals_group = vim.api.nvim_create_augroup("pjl-nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = self.ft,
            callback = function()
                require("metals").initialize_or_attach(opts)
            end,
            group = nvim_metals_group,
        })
    end
}
