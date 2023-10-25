local M = {}

function M.populate(title, command)
    local lines = vim.fn.systemlist(command)
    vim.fn.setqflist({}, 'r', { title = title, lines = lines })
    vim.cmd('copen')
end

local language_files = vim.api.nvim_get_runtime_file('lua/dev/core/quickfix-languages/*.lua', true)
for _, language_file in ipairs(language_files) do
    language = language_file:match(".+/([^/]+)%.lua")
    require('dev.core.quickfix-languages.' .. language)(M.populate)
end

return M
