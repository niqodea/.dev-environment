cmp_nvim_lsp = require("cmp_nvim_lsp")
cmp_nvim_lsp.setup()
require('lspconfig')['pyright'].setup {
    capabilities = cmp_nvim_lsp.default_capabilities()
}

