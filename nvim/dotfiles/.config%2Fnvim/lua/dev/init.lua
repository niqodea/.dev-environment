require('dev.core')

-- Extract module names from files
local module_files = vim.api.nvim_get_runtime_file('lua/dev/modules/*.lua', true)
local modules = {}
for _, module_file in ipairs(module_files) do
    local module = module_file:match(".+/([^/]+)%.lua")
    table.insert(modules, module)
end

-- Create start commands for modules
for _, module in ipairs(modules) do
    local capitalized_module = module:gsub('^%l', string.upper)
    local start_command = 'DevStart' .. capitalized_module
    local module_path = 'dev.modules.' .. module
    vim.api.nvim_create_user_command(start_command, function()
        require(module_path)
    end, {})
end

-- Create start command for all modules
vim.api.nvim_create_user_command('DevAssemble', function()
    for _, module in ipairs(modules) do
        local module_path = 'dev.modules.' .. module
        require(module_path)
    end
end, {})

-- Create startup commands for automatic loading of modules
local atdir = require('dev.core.utils').get_atdir()
local startup_path = atdir .. '/startup.nvim-dev'
vim.api.nvim_create_user_command('DevStartupEdit', function()
    vim.cmd('edit ' .. startup_path)
    if vim.fn.filereadable(startup_path) == 0 then
        local lines = {}
        for _, module in ipairs(modules) do
            table.insert(lines, '# ' .. module)
        end
        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    end
end, {})
vim.api.nvim_create_user_command('DevStartupAssemble', function()
    local startup_file = io.open(startup_path, 'w')
    for _, module in ipairs(modules) do
        startup_file:write(module .. '\n')
    end
    startup_file:close()
end, {})
vim.api.nvim_create_user_command('DevStartupRun', function()
    if vim.fn.filereadable(startup_path) == 0 then
        error('Startup file does not exist: ' .. startup_path)
    end
    local startup_file = io.open(startup_path, 'r')
    for line in startup_file:lines() do
        if line:match('^%s*#') or line:match('^%s*$') then
            goto continue
        end
        local module = line:match('^%s*(%S+)')
        local module_path = 'dev.modules.' .. module
        require(module_path)
        ::continue::
    end
end, {})
