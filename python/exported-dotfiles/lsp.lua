return function(cmp_nvim_lsp)
    -- Best lightweight server, but no environment-wide autoimport
    -- Also document symbols currently include imports
    -- Ref: https://github.com/pappasam/jedi-language-server/issues/288
    vim.lsp.config('jedi_language_server', {
        cmd = { 'jedi-language-server' },
        filetypes = { 'python' },
        root_markers = { '.' },
        capabilities = {
            textDocument = {
                completion = cmp_nvim_lsp.default_capabilities().textDocument.completion,
                documentSymbol = {
                    hierarchical_document_symbol_support = true,
                },
            },
        },
    })
    vim.lsp.enable('jedi_language_server')

    local ropefolder = require('dev.core.utils').get_atdir() .. '/ropeproject'

    vim.api.nvim_create_user_command('PythonRopifyMoveModule', function()
        local resource = vim.fn.expand('%')
        local command = 'ropify move-module ' .. resource .. ' --ropefolder ' .. ropefolder
        vim.cmd('split | terminal ' .. command)
        vim.api.nvim_buf_set_option(0, 'buflisted', false)
    end, {})

    vim.api.nvim_create_user_command('PythonRopifyMoveSymbol', function()
        local resource = vim.fn.expand('%')
        local offset = vim.fn.line2byte(vim.fn.line('.')) + vim.fn.col('.') - 1
        local command = 'ropify move-symbol ' .. resource .. ' ' .. offset .. ' --ropefolder ' .. ropefolder
        vim.cmd('split | terminal ' .. command)
        vim.api.nvim_buf_set_option(0, 'buflisted', false)
    end, {})

    vim.api.nvim_create_user_command('PythonRopifyShowImports', function()
        local name = vim.fn.expand('<cword>')
        local command = 'ropify show-imports ' .. name .. ' --ropefolder ' .. ropefolder
        vim.cmd('split | terminal ' .. command)
        vim.api.nvim_buf_set_option(0, 'buflisted', false)
    end, {})

    -- TODO: Try ty LSP
end
