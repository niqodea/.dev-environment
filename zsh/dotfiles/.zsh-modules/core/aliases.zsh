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

# Print current working directory
alias p='pwd'

# TODO: Extract this as a separate module

# TODO: Maybe use compress_path with small params in the future, will need to be refactored though
function prompt_venv() {
    local venv_project="$VIRTUAL_ENV_PROJECT"
    local venv_project_basename="$(basename "$venv_project")"
    local venv_project_burger="$(burger_hash "$venv_project_basename" 4 2 2 " ")"
    local venv_project_path_id="$(dirname "$venv_project" | md5sum | cut -c 1-2)"
    printf '%s' "$venv_project_burger|$venv_project_path_id"
}

# Activate venv
function av () {
    if [ -n "${VIRTUAL_ENV+x}" ]; then
        >&2 echo "A virtual environment is already activated: $VIRTUAL_ENV"
        return 1
    fi

    local venv_path="$PWD/$WORKSPACE_CONFIG_DIR/venv"

    if [ ! -d "$venv_path" ]; then
        >&2 echo "No virtual environment found at $venv_path"
        return 1
    fi

    export VIRTUAL_ENV_PROJECT="$PWD"
    export VIRTUAL_ENV="$venv_path"
    export PATH="$venv_path/bin:$PATH"

    local color_venv='%F{208}'  # Orange
    setup_prompt_base "$PROMPT_BASE$color_venv"'{$(prompt_venv)}'
}

function cdv () {
    if [ -z "${VIRTUAL_ENV_PROJECT+x}" ]; then
        >&2 echo "No active virtual environment with corresponding project found"
        return 1
    fi

    cd "$VIRTUAL_ENV_PROJECT"
}

alias pv='echo "$VIRTUAL_ENV_PROJECT"'
