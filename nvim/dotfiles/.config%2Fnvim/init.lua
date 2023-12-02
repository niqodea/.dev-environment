-- Use space as leader
vim.g.mapleader = '<Space>'
vim.api.nvim_set_keymap('', '<Space>', '', {noremap = true})
-- Enable comfy leader + ctrl commands
vim.api.nvim_set_keymap('', '<C-Space>', '<Space>', {noremap = false})
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
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<C-t>', ':tabnew<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<C-n>', ':tabnext<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<C-p>', ':tabprevious<cr>', {noremap = true})

-- Quick common actions
vim.api.nvim_set_keymap('n', vim.g.mapleader..'q', ':quit<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'Q', ':qall<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'w', ':write<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'W', ':wall<cr>', {noremap = true})
-- These edits are effectively used to reload files
vim.api.nvim_set_keymap('n', vim.g.mapleader..'e', ':edit<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'E', ':lua require("utils").reload_buffers()<cr>', {noremap = true})

-- Quick yank to and put from plus register (system clipboard)
vim.keymap.set({'n', 'v'}, vim.g.mapleader..'y', '"+y')
vim.keymap.set('n', vim.g.mapleader..'Y', '"+Y')
vim.keymap.set('n', vim.g.mapleader..'p', '"+p')

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


-- Dev module
vim.api.nvim_create_user_command('DevStart', function()
    require('dev')
end, {})
