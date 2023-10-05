local utils = require('dev.utils')

local workspace_config_dir = utils.get_workspace_config_dir()
if vim.fn.isdirectory(workspace_config_dir) == 0 then
    error('Workspace config directory does not exist: ' .. workspace_config_dir)
end

local base_module_path = {}  -- Root module
local modules = {'lsp', 'git', 'fzf', 'lasso', 'copilot'}

vim.api.nvim_create_user_command('DevCreateStartup', function()
    local startup_path = utils.get_startup_path(base_module_path)
    utils.create_startup_file(startup_path, modules)
    vim.cmd('edit ' .. startup_path)
end, {})

-- Create start commands for modules
local function create_start_command(name, module_path_str)
    vim.api.nvim_create_user_command(start_command, function()
        require(module_path_str)
    end, {})
end
for _, module in ipairs(modules) do
    local module_path = utils.get_module_path(base_module_path, module)
    local start_command = utils.get_start_command(module_path)
    local module_path_str = utils.get_module_path_str(module_path)
    create_start_command(start_command, module_path_str)
end

-- Recursively run startup files
local function run_startup(base_module_path)
    local startup_path = utils.get_startup_path(base_module_path)
    if vim.fn.filereadable(startup_path) == 0 then
        return
    end

    local startup_file = io.open(startup_path, 'r')
    for line in startup_file:lines() do
        if line:match('^%s*#') or line:match('^%s*$') then
            goto continue
        end


        local module = line:match('^%s*(%S+)')
        local module_path = utils.get_module_path(base_module_path, module)
        local start_command = utils.get_start_command(module_path)
        vim.api.nvim_command(start_command)


        run_startup(module_path)

        ::continue::
    end
end
vim.api.nvim_create_user_command('DevRunStartup', function()
    run_startup(base_module_path)
end, {})

