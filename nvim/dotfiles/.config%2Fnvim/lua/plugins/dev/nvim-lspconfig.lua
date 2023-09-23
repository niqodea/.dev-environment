local lsp_prefix = vim.g.mapleader..';'  -- Mnemonics: a staple symbol of many languages

vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'

vim.keymap.set('n', lsp_prefix..'d', vim.lsp.buf.definition)
vim.keymap.set('n', lsp_prefix..'D', vim.lsp.buf.declaration)
vim.keymap.set('n', lsp_prefix..'e', vim.diagnostic.open_float)
vim.keymap.set('n', lsp_prefix..'i', vim.lsp.buf.implementation)
vim.keymap.set('n', lsp_prefix..'h', vim.lsp.buf.hover)
vim.keymap.set('n', lsp_prefix..'n', vim.lsp.buf.rename)
vim.keymap.set('n', lsp_prefix..'r', vim.lsp.buf.references)
vim.keymap.set('n', lsp_prefix..'t', vim.lsp.buf.type_definition)

-- Disable inline and gutter diagnostic
-- Ref: https://github.com/neovim/nvim-lspconfig/issues/662#issuecomment-983423169
vim.diagnostic.config({virtual_text = false, signs = false})

-- Use meaningful colors for errors and warnings
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, ctermfg = 'DarkRed' })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, ctermfg = 'DarkYellow' })

-- Language server start commands
vim.api.nvim_create_user_command('LspStartPython', function()
    require('lspconfig').pyright.setup{
        capabilities = require('cmp_nvim_lsp').default_capabilities()
    }
    vim.cmd('LspStart')
end, {})
