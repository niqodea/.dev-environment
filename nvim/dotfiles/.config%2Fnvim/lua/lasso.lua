local M = {}


local function get_root()
    local root = os.getenv('NVIM_LASSO_ROOT') or os.getenv('HOME')
    return root
end


local function get_index_bufnr()
    local root = get_root()
    local index_filename = '.index.lasso'
    local index_path = root .. '/' .. index_filename

    local existing_index_bufnr = vim.fn.bufnr(index_path)
    if existing_index_bufnr ~= -1 then
        return existing_index_bufnr
    end

    local new_index_bufnr = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(new_index_bufnr, index_path)
    vim.api.nvim_buf_call(new_index_bufnr, vim.cmd.edit)

    -- Equip index file with local keybind to open files
    vim.api.nvim_buf_create_user_command(new_index_bufnr, 'LassoOpenFile', function()
        local file_relpath = vim.fn.getline('.')
        local file_path = root .. '/' .. file_relpath
        local buffer_name = vim.fn.fnamemodify(file_path, ':.')
        vim.cmd('edit ' .. vim.fn.fnameescape(buffer_name))
    end, {})
    vim.api.nvim_buf_set_keymap(
        new_index_bufnr,
        'n',
        '<CR>',
        '<cmd>LassoOpenFile<CR>',
        {noremap = true, silent = true}
    )

    return new_index_bufnr
end


function M.mark_file()
    if vim.api.nvim_buf_get_option(0, 'buftype') ~= '' then
        error('The current buffer is not associated with a regular file')
    end

    local root = get_root()
    local index_bufnr = get_index_bufnr()

    local buffer_name = vim.fn.expand('%')
    local file_path = vim.fn.fnamemodify(buffer_name, ':p')  -- absolute path

    local root_prefix = root .. '/'

    if file_path:sub(1, #root_prefix) ~= root_prefix then
        error('Path ' .. file_path .. ' is not contained in lasso root ' .. root)
    end

    local file_relpath = file_path:sub(#root_prefix + 1)

    local lines = vim.api.nvim_buf_get_lines(index_bufnr, 0, -1, false)
    for _, line in ipairs(lines) do
        if line == file_relpath then return end
    end

    local content = table.concat(lines, '\n')
    if content == '' then
        -- File is empty, set first line
        vim.api.nvim_buf_set_lines(index_bufnr, 0, 1, false, {file_relpath})
    else
        -- Append to the file
        vim.api.nvim_buf_set_lines(index_bufnr, -1, -1, false, {file_relpath})
    end

end


function M.open_marked_file(n)
    local root = get_root()
    local index_bufnr = get_index_bufnr()

    local n_ = n - 1  -- zero-based numbering
    local lines = vim.api.nvim_buf_get_lines(index_bufnr, n_, n_ + 1, false)

    if #lines == 0 then
        error('Lasso index file has no entry #' .. n)
    end

    local file_relpath = lines[1]
    local file_path = root .. '/' .. file_relpath
    local buffer_name = vim.fn.fnamemodify(file_path, ':.')
    vim.cmd('edit ' .. vim.fn.fnameescape(buffer_name))
end


function M.open_index_file()
    local index_bufnr = get_index_bufnr()
    vim.api.nvim_win_set_buf(0, index_bufnr)
end


return M

