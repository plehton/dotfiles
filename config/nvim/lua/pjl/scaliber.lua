local scaliber = {}

-- extracts table name from raw config target, from the line
-- containing '- table:'
--
scaliber.get_table_name = function()

    -- local col = vim.fn.col('.')
    local line = vim.fn.getline('.')

    local table_name = line:match('^%s+[-] table: (.*)$')
    if not table_name then
        print("Current line has no table reference")
        return nil
    end

    return table_name

end

-- opens table configuration 
scaliber.open_table_config = function()

    local table_name = scaliber.get_table_name()
    if table_name == nil then
        return ""
    end

    print("Open: " .. table_name)
    vim.api.nvim_command("normal! m`")
    vim.api.nvim_command("e " .. 'configurations/table/' .. table_name .. '.yml')

end

scaliber.open_table_references = function()

    local table_name = vim.fn.expand('%:t:r')
    vim.api.nvim_command('vimgrep /' .. table_name .. '/ configurations/raw/*.yml')
    vim.cmd('copen')

end
return scaliber
