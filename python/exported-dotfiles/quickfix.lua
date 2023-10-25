return function(populate_quickfix)
    local title = 'Mypy'
    local mypy_base_command = 'mypy --show-column-numbers --no-error-summary '

    vim.api.nvim_create_user_command('PythonMypy', function()
        local file_path = vim.fn.expand('%:p')
        local command = mypy_base_command .. file_path
        populate_quickfix(title, command)
    end, {})

    vim.api.nvim_create_user_command('PythonMypyProject', function()
        local command = mypy_base_command .. vim.fn.getcwd()
        populate_quickfix(title, command)
    end, {})

end
