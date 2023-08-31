require("nvim-tree").setup {
    actions = {
        change_dir = {
            restrict_above_cwd = true,
        },
    },
    renderer = {
        root_folder_label = ":~:s?$??",
        indent_markers = {
            enable = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "├",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
            symlink_arrow = " > ",
            show = {
                file = false,
                folder = false,
                folder_arrow = true,
                git = false,
                modified = false,
            },
            glyphs = {
                folder = {
                    arrow_closed = "^",
                    arrow_open = "v",
                },
            },
        },
    },
}

vim.api.nvim_set_keymap(
    'n',
    vim.g.mapleader..'d',
    '<cmd>NvimTreeFocus<CR>',
    {noremap = true}
)

