vim.g.lightspeed_no_default_keymaps = true

require('lightspeed').setup {
    ignore_case = true,
    safe_labels = {},
}

-- Note: using <leader>s instead of s has some advantages:
-- - No need to use z instead of s for operator-pending mode
-- - No weird "repeat s to go to next bigram" feature/bug when jumping to label s
vim.keymap.set('', '<leader>s', '<Plug>Lightspeed_s', {})
vim.keymap.set('', '<leader>S', '<Plug>Lightspeed_S', {})

