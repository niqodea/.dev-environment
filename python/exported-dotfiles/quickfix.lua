return function(generate_quickfix)
    local mypy_base_command = 'mypy --show-column-numbers --no-error-summary '

    vim.api.nvim_create_user_command('PythonMypy', function()
        local file_path = vim.fn.expand('%:p')
        local command = mypy_base_command .. file_path
        generate_quickfix(command)
    end, {})

    vim.api.nvim_create_user_command('PythonMypyProject', function()
        local command = mypy_base_command .. vim.fn.getcwd()
        generate_quickfix(command)
    end, {})

end
