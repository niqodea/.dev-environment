vim.cmd('packadd gitsigns.nvim')
require('gitsigns').setup()

-- Add sign column of size 1 for git signs
vim.wo.signcolumn = 'yes:1'

vim.api.nvim_set_hl(0, "GitSignsAdd", { ctermfg = 'DarkGreen' })
vim.api.nvim_set_hl(0, "GitSignsChange", { ctermfg = 'DarkYellow' })
vim.api.nvim_set_hl(0, "GitSignsDelete", { ctermfg = 'DarkRed' })

-- TODO: Add gitsigns keybindings for hunks

-- Fuzzy find through git files
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'fg-',
    '<cmd>lua require("dev.core").fuzzy.fzf_lua.git_files()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'fg/',
    '<cmd>lua require("dev.core").fuzzy.fzf_lua.live_grep({ cmd = "git grep --line-number --column" })<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'fg*',
    '<cmd>lua require("dev.core").fuzzy.fzf_lua.grep_cword({ cmd = "git grep --line-number --column" })<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'v',
    vim.g.mapleader..'fg*',
    '<cmd>lua require("dev.core").fuzzy.fzf_lua.grep_visual({ cmd = "git grep --line-number --column" })<CR>',
    {noremap = true}
)

vim.api.nvim_create_user_command('GitStatus', function()
    local name = 'git-status'
    local command = 'git status --short'
    require('dev.core').command.open_buffer(name, command)
end, {})
