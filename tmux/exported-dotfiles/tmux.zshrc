if [ -n "$TMUX" ]; then
    export TMUX_SESSION_START_DIRECTORY=$(pwd)
    alias cds="cd $TMUX_SESSION_START_DIRECTORY"

    # Set pane title to running command
    # Initially set the pane title to empty string
    tmux select-pane -T ""
    function set_tmux_pane_title() {
        COMMAND=$1
        tmux select-pane -t $TMUX_PANE -T $COMMAND
    }
    function reset_tmux_pane_title() {
        tmux select-pane -t $TMUX_PANE -T ""
    }
    # Call these functions before and after a command
    preexec_functions+=(set_tmux_pane_title)
    precmd_functions+=(reset_tmux_pane_title)

fi

