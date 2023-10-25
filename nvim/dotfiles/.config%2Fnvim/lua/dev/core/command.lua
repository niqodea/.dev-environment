local M = {}

function M.open_buffer(name, command)
    local bufname = 'dev://command/' .. name
    local bufnr = vim.fn.bufnr(bufname)
    if bufnr == -1 then
        bufnr = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(bufnr, bufname)
        vim.api.nvim_buf_set_option(bufnr, 'buftype', 'nofile')
    end
    command_output_lines = vim.fn.systemlist(command)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, command_output_lines)
    vim.api.nvim_win_set_buf(0, bufnr)
end

return M
