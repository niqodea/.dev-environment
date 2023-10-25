return function(set_qflist, set_loclist)
    local title = 'Mypy'
    local mypy_base_command = 'mypy --show-column-numbers --no-error-summary '

    vim.api.nvim_create_user_command('PythonMypy', function()
        local file_path = vim.fn.expand('%:p')
        local command = mypy_base_command .. file_path
        set_loclist(title, command)
    end, {})

    vim.api.nvim_create_user_command('PythonMypyProject', function()
        local command = mypy_base_command .. vim.fn.getcwd()
        set_qflist(title, command)
    end, {})

end
