vim.cmd('packadd gitsigns.nvim')
require('gitsigns').setup()

-- Add sign column of size 1 for git signs
vim.wo.signcolumn = 'yes:1'

vim.api.nvim_set_hl(0, "GitSignsAdd", { ctermfg = 'DarkGreen' })
vim.api.nvim_set_hl(0, "GitSignsChange", { ctermfg = 'DarkYellow' })
vim.api.nvim_set_hl(0, "GitSignsDelete", { ctermfg = 'DarkRed' })

-- TODO: Add gitsigns keybindings for hunks

-- Fuzzy find through git files
local fzf_lua = require('dev.core').fuzzy.fzf_lua
vim.keymap.set('n', vim.g.mapleader..'fg-', function() fzf_lua.git_files() end)
vim.keymap.set('n', vim.g.mapleader..'fg/', function()
    fzf_lua.live_grep({ cmd = "git grep --line-number --column" })
end)
vim.keymap.set('n', vim.g.mapleader..'fg*', function()
    fzf_lua.grep_cword({ cmd = "git grep --line-number --column" })
end)
vim.keymap.set('v', vim.g.mapleader..'fg*', function()
    fzf_lua.grep_visual({ cmd = "git grep --line-number --column" })
end)

vim.api.nvim_create_user_command('GitStatus', function()
    vim.cmd('terminal git status --short')
end, {})
