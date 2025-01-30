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
    settings = {
        python = {
            pythonPath = get_python_path(),
            venvPath = "",
        },
    },
}
