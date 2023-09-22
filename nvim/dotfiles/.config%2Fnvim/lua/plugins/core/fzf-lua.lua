-- Set POSIX-compliant find command for MacOS
require('fzf-lua').setup({
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

