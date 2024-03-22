if [ -z "$TMUX_PANE" ]; then
    >&2 echo 'Error: not in a TMUX pane'
    return
fi

function () {
    if [ "$ZSH_TMUX_HOOKS_SETUP" = 'true' ]; then
        return
    fi

    export ZSH_TMUX_HOOKS_SETUP='true'

    function set_tmux_pane_idle() {
        tmux select-pane -t "$TMUX_PANE" -T ''
        tmux set-option -t "$TMUX_PANE" -p @status idle
    }
    function set_tmux_pane_running() {
        # Set pane title to running command
        COMMAND="$1"
        # Escape newlines, otherwise tmux will not display the title
        tmux select-pane -t "$TMUX_PANE" -T "${COMMAND//$'\n'/\\n}"
        tmux set-option -t "$TMUX_PANE" -p @status running
    }
    # Initially set the pane to idle
    set_tmux_pane_idle
    # Call these functions before and after a command
    preexec_functions+=(set_tmux_pane_running)
    precmd_functions+=(set_tmux_pane_idle)
}
