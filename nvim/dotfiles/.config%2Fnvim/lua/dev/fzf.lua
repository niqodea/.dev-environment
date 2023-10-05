vim.cmd('packadd fzf-lua')
require('fzf-lua').setup({
    -- Set POSIX-compliant find command for MacOS
    files = { cmd = 'find . -type f' }
})

vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'f-',
    '<cmd>lua require("fzf-lua").files()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'f/',
    '<cmd>lua require("fzf-lua").live_grep()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'f*',
    '<cmd>lua require("fzf-lua").grep_cword()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'v',
    vim.g.mapleader..'f*',
    '<cmd>lua require("fzf-lua").grep_visual()<CR>',
    {noremap = true}
)

-- Restrict to git files
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'fg-',
    '<cmd>lua require("fzf-lua").git_files()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'fg/',
    '<cmd>lua require("fzf-lua").live_grep({ cmd = "git grep --line-number --column" })<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'fg*',
    '<cmd>lua require("fzf-lua").grep_cword({ cmd = "git grep --line-number --column" })<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'v',
    vim.g.mapleader..'fg*',
    '<cmd>lua require("fzf-lua").grep_visual({ cmd = "git grep --line-number --column" })<CR>',
    {noremap = true}
)
