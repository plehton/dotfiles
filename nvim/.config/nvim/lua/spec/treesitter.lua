return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ':TSUpdate',
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "gitcommit",
                "hcl",
                "hocon",
                "json",
                "lua",
                "python",
                "scala",
                "vim",
                "vimdoc",
                "yaml",
            },
            sync_install = false,
            auto_install = false,

            highlight = {
                enable = false,

                -- disable highlighting for files larger than 100kb
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,

                additional_vim_regex_highlighting = false,

            },

            indent = { enable = false, },

            fold = { enable = true },
        })
    end
}
