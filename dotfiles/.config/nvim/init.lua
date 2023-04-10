-- Use space as leader
-- Ref: https://stackoverflow.com/a/446293
vim.api.nvim_set_keymap('', ' ', '', {noremap = true})
vim.g.mapleader = " "

-- Moving up and down faster in normal mode
vim.api.nvim_set_keymap('', 'J', '5j', {})
vim.api.nvim_set_keymap('', 'K', '5k', {})

-- Remap joining lines
vim.api.nvim_set_keymap('', vim.g.mapleader..'j', 'J', {noremap = true})

-- Easier switching between splits
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true})

-- Easier tab handling
vim.api.nvim_set_keymap('n', vim.g.mapleader..'tt', ':tabnew<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'tn', ':tabnext<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'tp', ':tabprevious<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'to', ':tabonly<cr>', {noremap = true})

-- Clean highlighted text
vim.api.nvim_set_keymap('', vim.g.mapleader..'/', ':nohlsearch<cr>', {noremap = true})

-- Turn tab into 4 spaces
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Disable mouse features
vim.o.mouse = ""

-- Show hybrid line numbers
-- Ref: https://jeffkreeftmeijer.com/vim-number
vim.o.number = true
vim.o.relativenumber = true

-- References:
-- * https://www.barbarianmeetscoding.com/boost-your-coding-fu-with-vscode-and-vim/elevating-your-worflow-with-custom-mappings

