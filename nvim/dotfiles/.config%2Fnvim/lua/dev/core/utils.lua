local M = {}

function M.get_workspace_config_dir()
    local workspace_config_dir = vim.fn.getenv('WORKSPACE_CONFIG_DIR')
    if workspace_config_dir == vim.NIL or workspace_config_dir == '' then
        error('WORKSPACE_CONFIG_DIR env variable is not set')
    end
    return workspace_config_dir
end

return M
