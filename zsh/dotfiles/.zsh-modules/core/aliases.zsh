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

function bkp () {
    local file_path="$1"
    if [ -z "$file_path" ]; then
        >&2 echo "No path provided"
        return 1
    fi
    if [ ! -e "$file_path" ]; then
        >&2 echo "Path does not exist: $file_path"
        return 1
    fi

    local backup_file_path="$file_path.bkp"
    if [ -e "$backup_file_path" ]; then
        bkp "$backup_file_path"
    fi

    mv -- "$file_path" "$backup_file_path"
}

# TODO: Extract this as a separate module

function prompt_venv() {
    local venv_workspace="$VIRTUAL_ENV_WORKSPACE"
    local venv_workspace_formatted_path="$(format_path "$venv_workspace" 1 1)"
    local escaped_venv_workspace_formatted_path="${venv_workspace_formatted_path//\%/%%/}"
    printf '%s' "$escaped_venv_workspace_formatted_path"
}

# Activate venv
function _activate_venv () {
    local venv_path="$1"

    if [ ! -d "$venv_path" ]; then
        >&2 echo "No virtual environment found at $venv_path"
        return 1
    fi

    if [ -n "$VIRTUAL_ENV" ]; then
        local previous_venv_path="$VIRTUAL_ENV"
        export VIRTUAL_ENV="$venv_path"
        export PATH="$venv_path/bin:${PATH//$previous_venv_path\/bin\:}"
    else
        export VIRTUAL_ENV="$venv_path"
        export PATH="$venv_path/bin:$PATH"
    fi
}
alias av='_activate_venv "$PWD/$WORKSPACE_CONFIG_DIR/venv"'
alias avv='_activate_venv "$PWD/.venv"'

function cdv () {
    local venv_path="$VIRTUAL_ENV"

    if [ -z "${venv_path+x}" ]; then
        >&2 echo "No active virtual environment found"
        return 1
    fi

    if [[ "$venv_path" == *"$WORKSPACE_CONFIG_DIR/venv" ]]; then
        local base_path="${venv_path%$WORKSPACE_CONFIG_DIR/venv}"
    elif [[ "$venv_path" == *"/.venv"  ]]; then
        local base_path="${venv_path%/.venv}"
    else
        local base_path="$venv_path"
    fi

    cd "$base_path"
}

alias pv='echo "$VIRTUAL_ENV"'
