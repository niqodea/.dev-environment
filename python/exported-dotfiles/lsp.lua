return function(lsp_config, cmp_nvim_lsp)
    -- Best lightweight server, but no environment-wide autoimport
    -- Also document symbols currently include imports
    -- Ref: https://github.com/pappasam/jedi-language-server/issues/288
    lsp_config.jedi_language_server.setup{
        capabilities = {
            textDocument = {
                completion = cmp_nvim_lsp.default_capabilities().textDocument.completion,
                documentSymbol = {
                    hierarchical_document_symbol_support = true,
                },
            },
        },
    }

    -- Best environment-wide autoimport, but quite heavy on resources
    -- lsp_config.pyright.setup{
    --     capabilities = cmp_nvim_lsp.default_capabilities(),
    -- }

    -- Very configurable, but also very slow for some reason
    -- lsp_config.pylsp.setup{
    --     capabilities = cmp_nvim_lsp.default_capabilities(),
    --     settings = {
    --         pylsp = {
    --             plugins = {
    --                 -- rope_autoimport = { enabled = true },
    --                 jedi_symbols = { include_import_symbols = false },
    --             }
    --         }
    --     }
    -- }

    -- Very fast, but also very buggy
    -- lsp_config.pylyzer.setup{
    --     capabilities = cmp_nvim_lsp.default_capabilities(),
    -- }
end
