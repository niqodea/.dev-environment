local M = {}

vim.cmd('packadd lasso.nvim')
M.lasso = require('lasso')
M.lasso.setup{marks_tracker_path = require('dev.core.utils').get_workspace_config_dir() .. '/lasso-marks-tracker'}

vim.api.nvim_set_keymap('n', vim.g.mapleader..'m', '<cmd>lua require("dev.core.lasso").lasso.mark_file()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'M', '<cmd>lua require("dev.core.lasso").lasso.open_marks_tracker()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F1>', '<cmd>lua require("dev.core.lasso").lasso.open_marked_file(1)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F2>', '<cmd>lua require("dev.core.lasso").lasso.open_marked_file(2)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F3>', '<cmd>lua require("dev.core.lasso").lasso.open_marked_file(3)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F4>', '<cmd>lua require("dev.core.lasso").lasso.open_marked_file(4)<cr>', {noremap = true})

return M
