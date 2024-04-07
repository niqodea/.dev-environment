function _activate_venv () {
    local venv_path="$1"

    if [ -n "$VIRTUAL_ENV" ]; then
        >&2 echo 'Error: a virtual environment is already active'
        return 1
    fi
    if [ ! -d "$venv_path" ]; then
        >&2 echo "No virtual environment found at $venv_path"
        return 1
    fi

    export VIRTUAL_ENV="$venv_path"
    export PATH="$venv_path/bin:$PATH"
}
alias av='_activate_venv "$PWD/$WORKSPACE_CONFIG_DIR/venv"; sm v'
alias avv='_activate_venv "$PWD/.venv"; sm v'

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
