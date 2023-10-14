-- Mnemonics: a staple symbol of many languages, also easy to type
local lsp_prefix = vim.g.mapleader..';'

vim.cmd('packadd nvim-lspconfig')
local lsp_config = require('lspconfig')

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


vim.cmd('packadd nvim-cmp')
local cmp = require('cmp')

vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'

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

vim.cmd('packadd cmp-nvim-lsp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
cmp_nvim_lsp.setup()


vim.cmd('packadd aerial.nvim')
require('aerial').setup({
    backends = { 'lsp' },
    -- We need to tell aerial we disabled LSP diagnostics to update on buffer change instead
    -- Ref: https://github.com/stevearc/aerial.nvim/issues/54#issuecomment-1028611526
    lsp = {
        diagnostics_trigger_update = false,
    },
})
vim.keymap.set('n', lsp_prefix..'s', '<cmd>AerialOpen<CR>')


-- Language servers setup
-- python
require('lspconfig').pyright.setup{
    capabilities = require('cmp_nvim_lsp').default_capabilities()
}

-- Start LSP service
vim.cmd('LspStart')
