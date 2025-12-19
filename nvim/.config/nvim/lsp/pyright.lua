-- Get path to the active python env
--
-- When using pyenv and automatic venv activation via .python-version file,
-- pyright is not able to resolve the active environment.
--
-- We also need to check if were running under `pyenv virtualenv` or
-- `python -m venv`, since both have their own way of telling the active
-- environment.
--
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
        'pyrightconfig.json',
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        '.git',
    },
    settings = {
        python = {
            pythonPath = get_python_path(),
            venvPath = "",
        },
        analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'openFilesOnly',
        },
    },
}
