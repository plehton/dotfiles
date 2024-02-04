return {
    { "nvim-treesitter/nvim-treesitter",
        name = 'treesitter',
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
                    "terraform",
                    "vim",
                    "yaml",
                },
                sync_install = false,
                auto_install = false,
                ignore_install = {},

                highlight = {
                    enable = true,

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

                indent = {
                    enable = true,
                    -- disable = { "yaml" }
                },

                fold = { enable = true },

                -- textobjects = {
                --     move = {
                --         enable = true,
                --         set_jumps = true, -- whether to set jumps in the jumplist
                --         goto_next_start = {
                --             ["]m"] = "@function.outer",
                --             ["]]"] = "@class.outer",
                --         },
                --         goto_next_end = {
                --             ["]M"] = "@function.outer",
                --             ["]["] = "@class.outer",
                --         },
                --         goto_previous_start = {
                --             ["[m"] = "@function.outer",
                --             ["[["] = "@class.outer",
                --         },
                --         goto_previous_end = {
                --             ["[M"] = "@function.outer",
                --             ["[]"] = "@class.outer",
                --         },
                --     },
                -- },
            })
        end
    },
    -- { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "treesitter" },
}
