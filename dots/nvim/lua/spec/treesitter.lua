local treesitter = {
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

            indent = { enable = true, },

            fold = { enable = true },

            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {

                        ["ab"] = { query = "@block.outer", desc = "Select outer part of a block" },
                        ["ib"] = { query = "@block.inner", desc = "Select inner part of a block" },

                        ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
                        ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },

                        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
                    },

                    -- Scala/Metals can't handle whitespace, so disable it
                    include_surrounding_whitespace = false

                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = { query = "@function.outer" },
                        ["]]"] = { query = "@class.outer" },
                    },
                    goto_previous_start = {
                        ["[m"] = { query = "@function.outer" },
                        ["[]"] = { query = "@class.outer" },
                    },
                    goto_next_end = {
                        ["]M"] = { query = "@function.outer" },
                    },
                    goto_previous_end = {
                        ["[M"] = { query = "@function.outer" },
                    },
                },
            },
        })
    end
}

local ts_text_objects = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "nvim-treesitter" }

return {
    treesitter,
    ts_text_objects
}
