return {
    { 'L3MON4D3/LuaSnip',
        lazy = true
    },
    {
        'hrsh7th/nvim-cmp',
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },

        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations
            local kind_icons = {
                Text = " ",
                Method = "󰆧",
                Function = "ƒ ",
                Constructor = " ",
                Field = "󰜢 ",
                Variable = " ",
                Constant = " ",
                Class = " ",
                Interface = "󰜰 ",
                Struct = " ",
                Enum = "了",
                EnumMember = " ",
                Module = "",
                Property = " ",
                Unit = " ",
                Value = "󰎠 ",
                Keyword = "󰌆 ",
                Snippet = " ",
                File = " ",
                Folder = " ",
                Color = " ",
            }

            cmp.setup({

                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                preselect = cmp.PreselectMode.Item,

                window = {
                    completion = {
                        border = "rounded",
                        scrollbar = false,
                        max_height = 10,
                    },
                    documentation = {
                        border = "rounded",
                        scrollbar = true,
                        max_height = 20,
                    },
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                            -- that way you will only jump inside the snippet region
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),

                sources = cmp.config.sources({
                        { name = "nvim_lsp_signature_help" },
                        {
                            name = "nvim_lsp",
                            ---@diagnostic disable-next-line: unused-local
                            entry_filter = function(entry, ctx)
                                return "Text" ~= require('cmp.types').lsp.CompletionItemKind[entry:get_kind()]
                            end
                        },
                    },
                    {
                        { name = "luasnip" },
                        { name = "buffer", keyword_length = 3 },
                        { name = "path" },
                    }),

                formatting = {
                    format = function(entry, vim_item)
                        -- Kind icons
                        -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
                        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

                        -- Limit the width of abbr (especially with scala and the
                        -- überlong function signatures
                        vim_item.abbr = string.sub(vim_item.abbr, 1, math.floor(vim.api.nvim_win_get_width(0) / 3))
                        -- Source
                        vim_item.menu = ({
                            buffer   = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip  = "[Snippet]",
                            path     = "[Path]",
                            cmdline  = "[Cmdline]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
            })

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "buffer" },
                }),
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "cmdline", keyword_length = 3 },
                    { name = "path" },
                }),
            })

            -- cmp completion sorting fix for scala/metals
            cmp.setup.filetype({ "scala", "sc", "sbt" }, {
                preselect = cmp.PreselectMode.None, -- disable preselection

                sorting = {
                    priority_weight = 2,
                    comparators = {
                        cmp.config.compare.offset, -- we still want offset to be higher to order after 3rd letter
                        cmp.config.compare.score, -- same as above
                        cmp.config.compare.sort_text, -- add higher precedence for sort_text, it must be above `kind`
                        cmp.config.compare.recently_used,
                        cmp.config.compare.kind,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                -- if you want to add preselection you have to set completeopt to new values
                completion = {
                    -- completeopt = 'menu,menuone,noselect'
                    completeopt = 'menu,menuone'
                }
            })
        end

    }
}
