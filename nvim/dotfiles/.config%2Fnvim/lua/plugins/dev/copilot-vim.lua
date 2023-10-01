vim.api.nvim_set_keymap('n', vim.g.mapleader..'?', '<cmd>Copilot panel<cr>', {noremap = true})

vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>(copilot-next)', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<Plug>(copilot-previous)', {noremap = true})
