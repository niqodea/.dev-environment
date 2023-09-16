if [ -n "$TMUX" ]; then
    NVIM_STATE_SYNC_LISTEN_ADDRESS=/tmp/nvim-state-sync-$(tmux display -p "#{window_id}")
    function write_nvim_buffers() {
        if [ -e $NVIM_STATE_SYNC_LISTEN_ADDRESS ]; then
            nvim --server $NVIM_STATE_SYNC_LISTEN_ADDRESS --remote-send '<C-\><C-N>:wall<CR>'
        fi
    }
    function read_nvim_files() }
        if [ -e $NVIM_STATE_SYNC_LISTEN_ADDRESS ]; then
            nvim --server $NVIM_STATE_SYNC_LISTEN_ADDRESS --remote-send '<C-\><C-N>:bufdo edit<CR>'
        fi
    }
    # Call these functions before and after a command
    preexec_functions+=(write_nvim_buffers)
    precmd_functions+=(read_nvim_files)
fi

