local get_python_path = function()
    if os.getenv("PYENV_VIRTUAL_ENV") then
        return vim.fn.system("echo -n $(pyenv which python)")
    elseif os.getenv("VIRTUAL_ENV") then
        return vim.fn.system("echo -n $(which python)")
    end
end

return {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        'pyrightconfig.json',
        '.git',
    },
    settings = {
        python = {
            pythonPath = get_python_path(),
            venvPath = "",
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
            },
        },
    },
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
            local params = {
                command = 'pyright.organizeimports',
                arguments = { vim.uri_from_bufnr(bufnr) },
            }

            -- Using client.request() directly because "pyright.organizeimports" is private
            -- (not advertised via capabilities), which client:exec_cmd() refuses to call.
            -- https://github.com/neovim/neovim/blob/c333d64663d3b6e0dd9aa440e433d346af4a3d81/runtime/lua/vim/lsp/client.lua#L1024-L1030
            client.request('workspace/executeCommand', params, nil, bufnr)
        end, {
            desc = 'Organize Imports',
        })
    end,
}
