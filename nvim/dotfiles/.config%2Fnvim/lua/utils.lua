local M = {}


function M.reload_buffers()
    local modified_bufnrs = {}
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) == false then
            goto continue
        end
        if vim.api.nvim_buf_get_option(bufnr, 'buftype') ~= '' then
            goto continue
        end
        if vim.api.nvim_buf_get_name(bufnr) == '' then
            goto continue
        end
        if vim.api.nvim_buf_get_option(bufnr, 'modified') then
            table.insert(modified_bufnrs, bufnr)
            goto continue
        end
        vim.api.nvim_buf_call(bufnr, function() vim.cmd('edit') end)
        ::continue::
    end

    if #modified_bufnrs > 0 then
        local qf_list = {}
        for _, bufnr in ipairs(modified_bufnrs) do
            local filename = vim.api.nvim_buf_get_name(bufnr)
            table.insert(
                qf_list,
                {
                    bufnr = bufnr,
                    filename = filename,
                    lnum = 1,
                    col = 1,
                    text = "buffer modified, could not read from file",
                }
            )
        end
        vim.fn.setqflist(qf_list)
        vim.cmd('copen')
    end
end


return M
