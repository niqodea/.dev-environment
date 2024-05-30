-- Use space as leader
vim.g.mapleader = '<Space>'
vim.keymap.set('', '<Space>', '')
-- Enable comfy leader + ctrl commands
vim.keymap.set('', '<C-Space>', '<Space>', {remap = true})
-- No leader timeout
vim.o.timeout = false

-- Easier split management
vim.keymap.set('n', vim.g.mapleader..'j', '<C-w>j')
vim.keymap.set('n', vim.g.mapleader..'k', '<C-w>k')
vim.keymap.set('n', vim.g.mapleader..'h', '<C-w>h')
vim.keymap.set('n', vim.g.mapleader..'l', '<C-w>l')
vim.keymap.set('n', vim.g.mapleader..'s', '<C-w>s')
vim.keymap.set('n', vim.g.mapleader..'v', '<C-w>v')
vim.keymap.set('n', vim.g.mapleader..'S', ':below split<cr>')
vim.keymap.set('n', vim.g.mapleader..'V', ':below vsplit<cr>')
-- Easier resizing of splits
vim.keymap.set('n', '<C-left>', '2<C-w><')
vim.keymap.set('n', '<C-down>', '2<C-w>+')
vim.keymap.set('n', '<C-up>', '2<C-w>-')
vim.keymap.set('n', '<C-right>', '2<C-w>>')

-- Easier tab handling
vim.keymap.set('n', vim.g.mapleader..'<C-t>', ':tabnew<cr>')
vim.keymap.set('n', vim.g.mapleader..'<C-n>', ':tabnext<cr>')
vim.keymap.set('n', vim.g.mapleader..'<C-p>', ':tabprevious<cr>')

-- Quick common actions
vim.keymap.set('n', vim.g.mapleader..'q', ':quit<cr>')
vim.keymap.set('n', vim.g.mapleader..'Q', ':quitall<cr>')
vim.keymap.set('n', vim.g.mapleader..'w', ':write<cr>')
vim.keymap.set('n', vim.g.mapleader..'W', ':wall<cr>')
vim.keymap.set('n', vim.g.mapleader..'e', ':edit<cr>')

-- Reload all buffers (basically the missing :eall)
vim.api.nvim_create_user_command('EditAll', require('utils').reload_buffers, {})
vim.keymap.set('n', vim.g.mapleader..'E', ':EditAll<cr>')

-- Quick yank to and put from plus register (system clipboard)
vim.keymap.set({'n', 'v'}, vim.g.mapleader..'y', '"+y')
vim.keymap.set({'n', 'v'}, vim.g.mapleader..'Y', '"+Y')
vim.keymap.set({'n', 'v'}, vim.g.mapleader..'p', '"+p')
vim.keymap.set({'n', 'v'}, vim.g.mapleader..'P', '"+P')

-- Remove instructions banner from netrw
vim.g.netrw_banner = 0
-- Quick file explorer (we use '-' for consistency with netrw)
vim.keymap.set('n', vim.g.mapleader..'-', ':Explore<cr>')
vim.api.nvim_create_user_command('ExploreCwd', require('utils').explore_cwd, {})
vim.api.nvim_create_user_command('ExploreGitRoot', require('utils').explore_git_root, {})
vim.api.nvim_create_user_command('ExploreVenv', require('utils').explore_venv, {})
vim.keymap.set('n', vim.g.mapleader..'__', ':ExploreCwd<cr>')
vim.keymap.set('n', vim.g.mapleader..'_g', ':ExploreGitRoot<cr>')
vim.keymap.set('n', vim.g.mapleader..'_v', ':ExploreVenv<cr>')

-- Quick exit from terminal mode
vim.keymap.set('t', '<C-\\><C-\\>', '<C-\\><C-n>')

-- Clean highlighted text
vim.keymap.set('', vim.g.mapleader..'/', ':nohlsearch<cr>')

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
