# Listing files
alias ls="ls --color"  # Add colors to ls
alias ll="ls -l -h"  # -h is for human-readable file size
alias la="ls -a"

# Easier navigation in directories
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Size of files
alias duh="du -hs"

# Find
alias f="find ."
alias fn="find . -name"

# Search specific processes
alias psg="ps -eo pid,user,etime,comm | grep"
# Kill them
alias k9="kill -9"  # SIGKILL

# Activate venv
function av () {
    if [ -n "${VIRTUAL_ENV+x}" ]; then
        >&2 echo "A virtual environment is already activated: $VIRTUAL_ENV"
        return 1
    fi

    local venv_path="$(pwd -P)/$WORKSPACE_CONFIG_DIR/venv"

    if [ ! -d $venv_path ]; then
        >&2 echo "No virtual environment found at $venv_path"
        return 1
    fi

    export VIRTUAL_ENV=$venv_path
    export PATH=$venv_path/bin:$PATH

    # Assign best effort id to the venv
    local venv_id=$(echo $venv_path | md5sum | cut -c 1-4)
    setup_prompt_base "[venv-$venv_id]$PROMPT_BASE"
}
