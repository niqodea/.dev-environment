local M = {}

vim.cmd('packadd nvim-comment')
M.nvim_comment = require('nvim_comment')

M.nvim_comment.setup{
    operator_mapping = vim.g.mapleader .. 'c',
    line_mapping = vim.g.mapleader .. 'cc',
}

return M
