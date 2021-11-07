local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        mappings = { i = { ["<esc>"] = actions.close } },
        prompt_prefix = "❯ " -- unicode Heavy Right-Pointing Angle Quotation Mark Ornament U+276F

    },
})
