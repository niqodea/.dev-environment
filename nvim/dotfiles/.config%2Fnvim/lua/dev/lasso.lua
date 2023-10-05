local workspace_config_dir = require('dev.utils').get_workspace_config_dir()

vim.cmd('packadd lasso')
require('lasso').setup({index_path = workspace_config_dir .. '/lasso-index'})

vim.api.nvim_set_keymap('n', vim.g.mapleader..'m', '<cmd>lua require("lasso").mark_file()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'M', '<cmd>lua require("lasso").open_index_file()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'1', '<cmd>lua require("lasso").open_marked_file(1)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'2', '<cmd>lua require("lasso").open_marked_file(2)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'3', '<cmd>lua require("lasso").open_marked_file(3)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'4', '<cmd>lua require("lasso").open_marked_file(4)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F1>', '<cmd>lua require("lasso").open_terminal(1)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F2>', '<cmd>lua require("lasso").open_terminal(2)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F3>', '<cmd>lua require("lasso").open_terminal(3)<cr>', {noremap = true})

