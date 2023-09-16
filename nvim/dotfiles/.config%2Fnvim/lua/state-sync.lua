local state_sync_listen_address = vim.fn.getenv("NVIM_STATE_SYNC_LISTEN_ADDRESS")
local server_listen_address = vim.api.nvim_eval("v:servername")

if not state_sync_listen_address then
    return
end

vim.api.nvim_create_user_command("StartStateSync", function()
    os.execute("ln -s " .. server_listen_address .. " " .. state_sync_listen_address)

    -- Clean the symlink when exiting neovim
    vim.api.nvim_exec("autocmd VimLeave * !rm -f " .. state_sync_listen_address, false)

end, {})
