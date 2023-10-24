local M = {}
local utils = require('dev.utils')

vim.cmd('packadd nvim-comment')
M.nvim_comment = require('nvim_comment')
M.nvim_comment.setup{
    operator_mapping = vim.g.mapleader .. 'c',
    line_mapping = vim.g.mapleader .. 'C',
}

vim.cmd('packadd nvim-snippy')
M.snippy = require('snippy')
M.snippy.setup{
    mappings = {
        is = {
            ['<C-s>'] = M.snippy.mapping.Expand,
            ['<Tab>'] = M.snippy.mapping.Next,
            ['<S-Tab>'] = M.snippy.mapping.Previous,
        },
    },
}

vim.cmd('packadd fzf-lua')
M.fzf_lua = require('fzf-lua')
M.fzf_lua.setup{
    -- Set POSIX-compliant find command for MacOS
    files = { cmd = 'find . -type f' }
}
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'f-',
    '<cmd>lua require("dev").fzf_lua.files()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'f/',
    '<cmd>lua require("dev").fzf_lua.live_grep()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'f*',
    '<cmd>lua require("dev").fzf_lua.grep_cword()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'v',
    vim.g.mapleader..'f*',
    '<cmd>lua require("dev").fzf_lua.grep_visual()<CR>',
    {noremap = true}
)

vim.cmd('packadd lasso')
M.lasso = require('lasso')
M.lasso.setup{index_path = utils.get_workspace_config_dir() .. '/lasso-index'}
vim.api.nvim_set_keymap('n', vim.g.mapleader..'m', '<cmd>lua require("dev").lasso.mark_file()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'M', '<cmd>lua require("dev").lasso.open_index_file()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'1', '<cmd>lua require("dev").lasso.open_marked_file(1)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'2', '<cmd>lua require("dev").lasso.open_marked_file(2)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'3', '<cmd>lua require("dev").lasso.open_marked_file(3)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'4', '<cmd>lua require("dev").lasso.open_marked_file(4)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F1>', '<cmd>lua require("dev").lasso.open_terminal(1)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F2>', '<cmd>lua require("dev").lasso.open_terminal(2)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F3>', '<cmd>lua require("dev").lasso.open_terminal(3)<cr>', {noremap = true})

local modules = {'lsp', 'treesitter', 'git', 'copilot'}

-- Create start commands for modules
local function get_start_command(module)
    local capitalized_module = module:gsub('^%l', string.upper)
    return 'Dev' .. capitalized_module .. 'Start'
end
for _, module in ipairs(modules) do
    local start_command = get_start_command(module)
    local module_path = 'dev.' .. module
    vim.api.nvim_create_user_command(start_command, function()
        require(module_path)
    end, {})
end

-- Create startup commands for automatic loading of modules
local startup_path = utils.get_workspace_config_dir() .. '/startup.nvim-dev'
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

return M
