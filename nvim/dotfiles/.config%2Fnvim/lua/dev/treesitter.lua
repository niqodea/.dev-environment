vim.cmd('packadd nvim-treesitter')
require('nvim-treesitter.configs').setup { highlight = { enable = true } }

-- Setup parsers for each language
local language_files = vim.api.nvim_get_runtime_file('lua/dev/treesitter-languages/*.lua', true)
for _, language_file in ipairs(language_files) do
    language = language_file:match(".+/([^/]+)%.lua")
    require('dev.treesitter-languages.' .. language)
end
