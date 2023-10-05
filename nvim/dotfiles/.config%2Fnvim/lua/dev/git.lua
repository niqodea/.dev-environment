-- TODO: Replace with a lua plugin
vim.cmd('packadd vim-gitgutter')

-- Do not set up any keybind by default
vim.g.gitgutter_map_keys = 0

-- Add sign column of size 1 for git signs
vim.wo.signcolumn = 'yes:1'
