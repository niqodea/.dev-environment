require('dev.core')

-- Extract module names from files
local module_files = vim.api.nvim_get_runtime_file('lua/dev/modules/*.lua', true)
local modules = {}
for _, module_file in ipairs(module_files) do
    local module = module_file:match(".+/([^/]+)%.lua")
    table.insert(modules, module)
end

-- Create start commands for modules
local function get_start_command(module)
    local capitalized_module = module:gsub('^%l', string.upper)
    return 'Dev' .. capitalized_module .. 'Start'
end
for _, module in ipairs(modules) do
    local start_command = get_start_command(module)
    local module_path = 'dev.modules.' .. module
    vim.api.nvim_create_user_command(start_command, function()
        require(module_path)
    end, {})
end

-- Create start command for all modules
vim.api.nvim_create_user_command('DevAllStart', function()
    for _, module in ipairs(modules) do
        local module_path = 'dev.modules.' .. module
        require(module_path)
    end
end, {})

-- Create startup commands for automatic loading of modules
local workspace_config_dir = require('dev.core.utils').get_workspace_config_dir()
local startup_path = workspace_config_dir .. '/startup.nvim-dev'
vim.api.nvim_create_user_command('DevCreateStartup', function()
    local startup_file = io.open(startup_path, 'w')
    for _, module in ipairs(modules) do
        startup_file:write('# ' .. module .. '\n')
    end
    startup_file:close()
    vim.cmd('edit ' .. startup_path)
end, {})
vim.api.nvim_create_user_command('DevRunStartup', function()
    if vim.fn.filereadable(startup_path) == 0 then
        error('Startup file does not exist: ' .. startup_path)
    end
    local startup_file = io.open(startup_path, 'r')
    for line in startup_file:lines() do
        if line:match('^%s*#') or line:match('^%s*$') then
            goto continue
        end
        local module = line:match('^%s*(%S+)')
        local start_command = get_start_command(module)
        vim.cmd(start_command)
        ::continue::
    end
end, {})
