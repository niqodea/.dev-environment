# Listing files
alias l='ls --color'  # Add colors to ls
alias la='l -a'
alias ll='l -hl'  # -h is for human-readable file size
alias lal='l -ahl'

# Easier navigation in directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Size of files
alias duh='du -hs'

# Find
alias f='find .'
alias fn='find . -name'

# Search specific processes
alias psg='ps -eo pid,user,etime,comm | grep'
# Kill them
alias k9='kill -9'  # SIGKILL

# Load updated global history
alias fcr='fc -R'

# Activate venv
function av () {
    if [ -n "${VIRTUAL_ENV+x}" ]; then
        >&2 echo "A virtual environment is already activated: $VIRTUAL_ENV"
        return 1
    fi

    local cwd="$(pwd)"
    local venv_path="$cwd/$WORKSPACE_CONFIG_DIR/venv"

    if [ ! -d "$venv_path" ]; then
        >&2 echo "No virtual environment found at $venv_path"
        return 1
    fi

    export VIRTUAL_ENV_PROJECT="$cwd"
    export VIRTUAL_ENV="$venv_path"
    export PATH="$venv_path/bin:$PATH"

    # Assign best effort id to the venv (probability of collision =~ 1/2^16)
    local venv_id="$(echo "$venv_path" | md5sum | cut -c 1-4)"
    setup_prompt_base "[venv-$venv_id]$PROMPT_BASE"
}

function cdv () {
    if [ -z "${VIRTUAL_ENV_PROJECT+x}" ]; then
        >&2 echo "No active virtual environment with corresponding project found"
        return 1
    fi

    cd "$VIRTUAL_ENV_PROJECT"
}
