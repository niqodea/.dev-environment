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
        vim.api.nvim_buf_call(bufnr, function()
            -- NOTE: editing a buffer with nvim_buf_call has the following issue:
            -- https://github.com/neovim/neovim/issues/25877
            -- For now, as a hack, we temporarily disable matchparen in the following way
            local matchpairs = vim.o.matchpairs
            vim.o.matchpairs = ""

            vim.cmd('edit')

            vim.o.matchpairs = matchpairs
        end)

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


function M.explore_cwd()
    -- `Explore .` won't work when already in netrw for some reason
    local cwd = vim.fn.getcwd()
    vim.cmd('Explore ' .. cwd)
end


function M.explore_git_root()
    local handle = io.popen('git rev-parse --show-toplevel 2> /dev/null')
    local git_root = handle:read('*line')
    handle:close()

    if git_root == nil then
        error('Not in a git repository')
    end

    vim.cmd('Explore ' .. git_root)
end


function M.explore_venv()
    local venv_path = vim.fn.getenv('VIRTUAL_ENV')

    if venv_path == nil then
        error('No VIRTUAL_ENV environment variable found')
    end

    vim.cmd('Explore ' .. venv_path)
end


function M.yank_path()
    local path = vim.fn.expand('%:.')
    vim.fn.setreg('+', path)
end


return M
