local M = {}

vim.cmd('packadd fzf-lua')
M.fzf_lua = require('fzf-lua')

M.fzf_lua.setup{
    -- Set POSIX-compliant find command for MacOS
    files = { cmd = 'find . -type f' }
}

vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'f-',
    '<cmd>lua require("dev.core.fuzzy").fzf_lua.files()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'f/',
    '<cmd>lua require("dev.core.fuzzy").fzf_lua.live_grep()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'f*',
    '<cmd>lua require("dev.core.fuzzy").fzf_lua.grep_cword()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'v',
    vim.g.mapleader..'f*',
    '<cmd>lua require("dev.core.fuzzy").fzf_lua.grep_visual()<CR>',
    {noremap = true}
)

return M
