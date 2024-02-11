return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    requires = { "nvim/lua/plenary.vim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
        vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        -- vim.keymap.set("n", "<leader>a", function() harpoon:list():select(1) end)
        -- vim.keymap.set("n", "<leader>s", function() harpoon:list():select(2) end)
        -- vim.keymap.set("n", "<leader>d", function() harpoon:list():select(3) end)
        -- vim.keymap.set("n", "<leader>f", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<Tab>", function() harpoon:list():next({ ui_nav_wrap = true }) end)
        vim.keymap.set("n", "<S-Tab>", function() harpoon:list():prev({ ui_nav_wrap = true }) end)
    end

}