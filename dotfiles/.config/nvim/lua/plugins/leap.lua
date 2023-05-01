-- Disable auto-jump to first match when more than one is found
require('leap').opts.safe_labels = {}

-- We prefer l rather than s for mnemonics
vim.keymap.set('', '<leader>l', '<Plug>(leap-forward)')
vim.keymap.set('', '<leader>L', '<Plug>(leap-backward)')

