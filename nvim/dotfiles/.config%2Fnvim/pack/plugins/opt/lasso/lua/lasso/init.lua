local M = {}


local config = {}


function M.setup(config_)
    config.index_path = config_.index_path or '.lasso-index'
end


local function get_index_bufnr()
    local existing_index_bufnr = vim.fn.bufnr(config.index_path)
    if existing_index_bufnr ~= -1 then
        return existing_index_bufnr
    end

    local new_index_bufnr = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(new_index_bufnr, config.index_path)
    vim.api.nvim_buf_call(new_index_bufnr, vim.cmd.edit)

    -- Equip index file with local keybind to open files
    vim.api.nvim_buf_create_user_command(new_index_bufnr, 'LassoOpenFile', function()
        local file_path = vim.fn.getline('.')
        vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
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

    local index_bufnr = get_index_bufnr()

    local buffer_name = vim.fn.expand('%')
    local file_path = vim.fn.fnamemodify(buffer_name, ':~:.')

    local lines = vim.api.nvim_buf_get_lines(index_bufnr, 0, -1, false)
    for _, line in ipairs(lines) do
        if line == file_path then return end
    end

    local content = table.concat(lines, '\n')
    if content == '' then
        -- File is empty, set first line
        vim.api.nvim_buf_set_lines(index_bufnr, 0, 1, false, {file_path})
    else
        -- Append to the file
        vim.api.nvim_buf_set_lines(index_bufnr, -1, -1, false, {file_path})
    end

end


function M.open_marked_file(n)
    local index_bufnr = get_index_bufnr()

    local n_ = n - 1  -- zero-based numbering
    local lines = vim.api.nvim_buf_get_lines(index_bufnr, n_, n_ + 1, false)

    if #lines == 0 then
        error('Lasso index file has no entry #' .. n)
    end

    local file_path = lines[1]
    vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
end


function M.open_index_file()
    local index_bufnr = get_index_bufnr()
    vim.api.nvim_win_set_buf(0, index_bufnr)
end


-- LASSO TERMINALS


local terminal_bufnrs = {}

function M.open_terminal(n)
    local bufnr = terminal_bufnrs[n]

    if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_win_set_buf(0, bufnr)
        return
    end

    vim.cmd('terminal')
    terminal_bufnrs[n] = vim.api.nvim_get_current_buf()
end


return M

