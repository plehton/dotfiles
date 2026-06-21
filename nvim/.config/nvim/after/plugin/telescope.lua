local multiopen = function(prompt_bufnr, open_cmd)
    local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()
    if not vim.tbl_isempty(multi) then
        if open_cmd == 'qf' then
            require 'telescope.actions'.send_selected_to_qflist(prompt_bufnr)
        end

        require('telescope.actions').close(prompt_bufnr)

        for i, j in pairs(multi) do
            if j.path ~= nil then
                local line = j.lnum ~= nil and j.lnum or 1
                local bufname = vim.api.nvim_buf_get_name(0)
                local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

                if i == 1 and bufname == "" and #lines == 1 and lines[1] == "" then
                    vim.cmd(string.format('%s %s', 'edit', j.path, line))
                else
                    vim.cmd(string.format('%s %s', open_cmd, j.path, line))
                end
            end
        end
    else
        if open_cmd == 'edit' then
            require('telescope.actions').select_default(prompt_bufnr)
        elseif open_cmd == 'vsplit' then
            require('telescope.actions').file_vsplit(prompt_bufnr)
        end
    end
end

local actions = {
    edit = function(prompt_bufnr) multiopen(prompt_bufnr, 'edit') end,
    vsp = function(prompt_bufnr) multiopen(prompt_bufnr, 'vsplit') end,
    sp = function(prompt_bufnr) multiopen(prompt_bufnr, 'split') end,
}

local yank_filename = function(prompt_bufnr)
    local selection = require('telescope.actions.state').get_selected_entry()
    if selection ~= nil then
        vim.fn.setreg('"', vim.fn.fnameescape(selection.path))
        require('telescope.actions').close(prompt_bufnr)
    end
end

require('telescope').setup({
    defaults = {
        sorting_strategy = "ascending",
        scroll_strategy = "limit",
        layout_config = {
            prompt_position = "top",
        },
        mappings = {
            n = {
                ['jk'] = "close",
                ['<CR>'] = actions.edit,
                ['<C-v>'] = actions.vsp,
                ['<C-x>'] = actions.sp,
                ['<C-q>'] = actions.qf,
                ['<C-y>'] = yank_filename,
            },
            i = {
                ['<CR>'] = actions.edit,
                ['<C-v>'] = actions.vsp,
                ['<C-x>'] = actions.sp,
                ['<C-q>'] = actions.qf,
                ['<C-y>'] = yank_filename,
            },
        },
    },
    pickers = {
        find_files = {
            hidden = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") == "dotfiles",
        },
        grep_string = {
            hidden = true,
        },
        live_grep = {
            hidden = true,
        },
    },
})

require("telescope").load_extension("fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<Leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<Leader>fm", builtin.oldfiles, { desc = "Telescope buffers" })
vim.keymap.set("n", "<Leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<Leader>fw", builtin.grep_string, { desc = "Telescope grep string under cursor" })
vim.keymap.set("n", "<Leader>ff", builtin.resume, { desc = "Telescope resume" })

vim.keymap.set("n", "<Leader>fd", function()
    builtin.find_files({ cwd = '~/code/dotfiles' })
end)

vim.keymap.set("n", "<Leader>fv", function()
    builtin.find_files({ cwd = vim.fn.stdpath('data') })
end)

vim.keymap.set("n", "gO", builtin.lsp_document_symbols)
vim.keymap.set("n", "grr", builtin.lsp_references)