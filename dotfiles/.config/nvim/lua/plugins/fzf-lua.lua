vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'ff',
    '<cmd>lua require("fzf-lua").files()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'fr',
    '<cmd>lua require("fzf-lua").live_grep()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'fw',
    '<cmd>lua require("fzf-lua").grep_cword()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'v',
    vim.g.mapleader..'fr',
    '<cmd>lua require("fzf-lua").grep_visual()<CR>',
    {noremap = true}
)


return {
    set_optional_git_keymaps = function()
        vim.api.nvim_set_keymap(
            'n',
            vim.g.mapleader..'fgf',
            '<cmd>lua require("fzf-lua").git_files()<CR>',
            {noremap = true}
        )
        vim.api.nvim_set_keymap(
            'n',
            vim.g.mapleader..'fgr',
            '<cmd>lua require("fzf-lua").live_grep({ cmd = "git grep --line-number --column --color=always" })<CR>',
            {noremap = true}
        )
        vim.api.nvim_set_keymap(
            'n',
            vim.g.mapleader..'fgw',
            '<cmd>lua require("fzf-lua").grep_cword({ cmd = "git grep --line-number --column --color=always" })<CR>',
            {noremap = true}
        )
        vim.api.nvim_set_keymap(
            'v',
            vim.g.mapleader..'fgr',
            '<cmd>lua require("fzf-lua").grep_visual()<CR>',
            {noremap = true}
        )
    end
}

