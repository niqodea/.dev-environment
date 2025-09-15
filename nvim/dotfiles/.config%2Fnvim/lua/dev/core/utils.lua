local M = {}

function M.get_atdir()
    local handle = vim.fn.getenv('ATDIR_HANDLE')
    if handle == vim.NIL or handle == '' then
        error('ATDIR_HANDLE env variable is not set')
    end
    return '.@' .. handle
end

return M
