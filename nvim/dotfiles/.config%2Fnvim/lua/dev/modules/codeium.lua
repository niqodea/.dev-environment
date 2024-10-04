vim.cmd('packadd codeium.vim')  -- codeium.nvim uses nvim-cmp, but we prefer virtual text

vim.keymap.set("i", "<C-l>", function()
    return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })

vim.keymap.set("i", "<C-j>", function()
    return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, silent = true })

vim.keymap.set("i", "<C-k>", function()
    return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true })
