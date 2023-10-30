export PATH=$HOME/.local/bin:$PATH
export WORKSPACE_CONFIG_DIR=.workspace-config

# Prevent tmux from asking the terminal emulator for capabilities, as this can cause the terminal
# emulator to send escape sequences that are not understood by tmux due to setting escape-time to 0.
# NOTE: This assumes that the terminal emulator in use supports these capabilities.
export TERM=tmux-256color
