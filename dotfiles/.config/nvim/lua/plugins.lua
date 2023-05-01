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
        'https://github.com/ggandor/lightspeed.nvim',
        commit = '299eefa6a9e2d881f1194587c573dad619fdb96f',
        config = [[require('plugins.lightspeed')]],
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
end)

-- User commands to load subsets of related optional plugins
vim.api.nvim_create_user_command('LoadDevEnv', function()
    vim.cmd('PackerLoad nvim-lspconfig')
    vim.cmd('PackerLoad vim-gitgutter')
end, {})

