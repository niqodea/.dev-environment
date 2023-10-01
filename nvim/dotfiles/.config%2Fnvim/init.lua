-- Use space as leader
-- Ref: https://stackoverflow.com/a/446293
vim.api.nvim_set_keymap('', ' ', '', {noremap = true})
vim.g.mapleader = " "
-- No leader timeout
vim.o.timeout = false

-- Easier split management
vim.api.nvim_set_keymap('n', vim.g.mapleader..'j', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'k', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'h', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'l', '<C-w>l', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', '2<C-w>+', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '2<C-w>-', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '2<C-w>>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-h>', '2<C-w><', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'s', '<C-w>s', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'v', '<C-w>v', {noremap = true})

-- Easier tab handling
vim.api.nvim_set_keymap('n', vim.g.mapleader..'t', ':tabnew<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'n', ':tabnext<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'p', ':tabprevious<cr>', {noremap = true})

-- Quick common actions
vim.api.nvim_set_keymap('n', vim.g.mapleader..'q', ':quit<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'w', ':write<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'Q', ':qall<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'W', ':wall<cr>', {noremap = true})

-- Quick file explorer (we use '-' for consistency with netrw)
vim.api.nvim_set_keymap('n', vim.g.mapleader..'-', ':Explore<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'_', ':Explore .<cr>', {noremap = true})
-- Remove instructions banner from netrw
vim.g.netrw_banner = 0

-- Quick exit from terminal mode
vim.api.nvim_set_keymap('t', '<C-\\><C-\\>', '<C-\\><C-n>', {noremap = true})

-- Clean highlighted text
vim.api.nvim_set_keymap('', vim.g.mapleader..'/', ':nohlsearch<cr>', {noremap = true})

-- Turn tab into 4 spaces
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Disable mouse features
vim.o.mouse = ""

-- Use smaller updatetime, used to make some things more responsive, such as git diff markers
vim.o.updatetime = 500

-- Show hybrid line numbers
-- Ref: https://jeffkreeftmeijer.com/vim-number
vim.o.number = true
vim.o.relativenumber = true

-- Color scheme
vim.cmd('colorscheme slate')

-- Load plugin handling logic
require("plugins.main")

-- Load submodules
lasso = require("lasso")
vim.api.nvim_set_keymap('n', vim.g.mapleader..'m', '<cmd>lua lasso.mark_file()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'M', '<cmd>lua lasso.open_index_file()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'1', '<cmd>lua lasso.open_marked_file(1)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'2', '<cmd>lua lasso.open_marked_file(2)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'3', '<cmd>lua lasso.open_marked_file(3)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'4', '<cmd>lua lasso.open_marked_file(4)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F1>', '<cmd>lua lasso.open_terminal(1)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F2>', '<cmd>lua lasso.open_terminal(2)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F3>', '<cmd>lua lasso.open_terminal(3)<cr>', {noremap = true})


-- References:
-- * https://www.barbarianmeetscoding.com/boost-your-coding-fu-with-vscode-and-vim/elevating-your-worflow-with-custom-mappings

