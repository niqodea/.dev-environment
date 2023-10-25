local M = {}

function M.generate_quickfix(command)
    local populate_command = 'cexpr system("' .. command .. '")'
    vim.cmd(populate_command)
    vim.cmd('copen')
end

local language_files = vim.api.nvim_get_runtime_file('lua/dev/core/quickfix-languages/*.lua', true)
for _, language_file in ipairs(language_files) do
    language = language_file:match(".+/([^/]+)%.lua")
    require('dev.core.quickfix-languages.' .. language)(M.generate_quickfix)
end

return M
