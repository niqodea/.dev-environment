vim.cmd('packadd nvim-treesitter')
local nvim_treesitter_configs = require('nvim-treesitter.configs')

nvim_treesitter_configs.setup {
    highlight = {
        enable = true,
        -- Required for some color schemes to work properly with treesitter
        -- Otherwise some tokens might not be highlighted
        -- Ref: https://stackoverflow.com/questions/78220353
        additional_vim_regex_highlighting = true,
    },
}

-- Setup parsers for each language
local language_files = vim.api.nvim_get_runtime_file('lua/dev/modules/treesitter-languages/*.lua', true)
for _, language_file in ipairs(language_files) do
    local language = language_file:match(".+/([^/]+)%.lua")
    require('dev.modules.treesitter-languages.' .. language)
end
