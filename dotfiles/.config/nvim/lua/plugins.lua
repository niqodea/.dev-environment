-- Packer is neat for centralizing plugins declaration in dotfiles and linking configs to plugins
-- However, it is an additional dependency that is not strictly needed
-- It also looks like the project might be dead
-- Ref: https://github.com/wbthomason/packer.nvim/issues/1229
-- If problems arise, we might want to stop using Packer in the future and link configs to plugins
-- in other ways, such as commands that run both packadd and require
packer = require('packer')

packer.init({
    -- Move package root from default ~/.local/share/nvim/site/pack
    package_root = '~/.config/nvim/pack',
})

packer.startup(function(use)
    use {
        'https://github.com/wbthomason/packer.nvim',
        commit = '1d0cf98a561f7fd654c970c49f917d74fafe1530',
    }
    use {
        'https://github.com/tpope/vim-commentary',
        commit = 'e87cd90dc09c2a203e13af9704bd0ef79303d755',
    }
    use {
        'https://github.com/tpope/vim-surround',
        commit = '3d188ed2113431cf8dac77be61b842acb64433d9',
    }
    use {
        'https://github.com/neovim/nvim-lspconfig',
        commit = 'cf95480e876ef7699bf08a1d02aa0ae3f4d5f353',
        opt = true,
        config = [[require('plugins.nvim-lspconfig')]],
    }
    use {
        'https://github.com/airblade/vim-gitgutter',
        commit = '44dbd57dd19e8ec58b2a50c787c8ae7bb231c145',
        opt = true,
        config = [[require('plugins.vim-gitgutter')]],
    }
    use {
        'https://github.com/hrsh7th/nvim-cmp',
        commit = '3874e09e80f5fd97ae941442f1dc433317298ae9',
        opt = true,
        config = [[require('plugins.nvim-cmp')]],
    }
    use {
        'https://github.com/hrsh7th/cmp-nvim-lsp',
        commit = '0e6b2ed705ddcff9738ec4ea838141654f12eeef',
        opt = true,
    }
end)

-- User commands to load subsets of related optional plugins
vim.api.nvim_create_user_command('LoadDevEnv', function()
    vim.cmd('PackerLoad nvim-lspconfig')
    vim.cmd('PackerLoad vim-gitgutter')
    vim.cmd('PackerLoad nvim-cmp')
end, {})

