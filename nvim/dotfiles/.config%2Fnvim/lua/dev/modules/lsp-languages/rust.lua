-- TODO: This config kind of works for now, but probably can be improved
return function(lsp_config, cmp_nvim_lsp)
    lsp_config.rust_analyzer.setup{
        settings = {
            ['rust-analyzer'] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true
                },
            },
        },
    }
end
