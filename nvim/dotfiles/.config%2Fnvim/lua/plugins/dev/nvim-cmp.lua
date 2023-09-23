-- This file is based on the recommended nvim-lspconfig configuration
-- Ref: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp

local cmp = require('cmp')
cmp.setup {
    sources = { { name = 'nvim_lsp' } },
    mapping = cmp.mapping.preset.insert(
        {
            -- Trigger completion menu
            ['<C-Space>'] = cmp.mapping.complete(),
            -- Scroll through completion item docs
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            -- Confirm selection item
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
        }
    ),
}

