vim.treesitter.language.add(
    'python',
    { path = os.getenv('HOME') ..'/.local/lib/tree-sitter/python.so' }
)
