local M = {}


function M.get_workspace_config_dir()
    local workspace_config_dir = vim.fn.getenv('WORKSPACE_CONFIG_DIR')
    if workspace_config_dir == vim.NIL or workspace_config_dir == '' then
        error('WORKSPACE_CONFIG_DIR env variable is not set')
    end
    return workspace_config_dir
end

function M.get_module_path(base_module_path, module)
    local module_path = {unpack(base_module_path)}
    table.insert(module_path, module)
    return module_path
end

function M.get_module_path_str(module_path)
    local module_path_str = 'dev'
    for _, module in ipairs(module_path) do
        module_path_str = module_path_str .. '.' .. module
    end
    return module_path_str
end

function M.get_start_command(module_path)
    start_command = 'Dev'
    for _, module in ipairs(module_path) do
        start_command = start_command .. module:gsub('^%l', string.upper)
    end
    start_command = start_command .. 'Start'
    return start_command
end

function M.get_startup_path(module_path)
    local startup_file_name_components = {unpack(module_path)}
    table.insert(startup_file_name_components, 'startup.nvim-dev')

    local workspace_config_dir = M.get_workspace_config_dir()
    local startup_file_name = table.concat(startup_file_name_components, '-')
    local startup_path = workspace_config_dir .. '/' .. startup_file_name
    return startup_path
end

function M.create_startup_file(startup_path, modules)
    local startup_file = io.open(startup_path, 'w')
    for _, module in ipairs(modules) do
        startup_file:write('# ' .. module .. '\n')
    end
    startup_file:close()
end

return M
