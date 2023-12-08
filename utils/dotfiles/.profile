export PATH="$HOME/.local/bin:$PATH"
export WORKSPACE_CONFIG_DIR=".workspace-config"

# Prevent tmux from asking the terminal emulator for capabilities, as this can cause the terminal
# emulator to send escape sequences that are not understood by tmux due to setting escape-time to 0.
# NOTE: This assumes that the terminal emulator in use supports these capabilities.
# NOTE: This TERM variable is not inherited by the tmux server when started from the shell
#       Use default-terminal to set the default TERM for the tmux server
export TERM="tmux-256color"

export PASSWORD_STORE_DIR="$HOME/.password-store"
