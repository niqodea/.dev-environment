function prompt_venv() {
    local venv_path="$VIRTUAL_ENV"
    local venv_formatted_path="$(format_venv_path "$venv_path")"
    local escaped_venv_formatted_path="${venv_formatted_path//\%/%%}"
    printf '%s' "$escaped_venv_formatted_path"
}

function format_venv_path() {
    local venv_path="$1"
    if [[ "$venv_path" == *"/.venv"  ]]; then
        local base_path="${venv_path%/.venv}"
        local postfix="."
    elif [[ "$venv_path" == *"$WORKSPACE_CONFIG_DIR/venv" ]]; then
        local base_path="${venv_path%$WORKSPACE_CONFIG_DIR/venv}"
        local postfix="w"
    else
        local base_path="$venv_path"
        local postfix=" "
    fi
    local prefix="$(format_path "$base_path" 1 1)"
    printf '%s' "$prefix/$postfix"
}

function() {
    if [ "$ZSH_VENV_SETUP" = 'true' ]; then
        return
    fi
    export ZSH_VENV_SETUP='true'

    local config="$(echo "$ZSH_EXTRA_MODULES" | jq -r '.venv')"
    local venv_path="$(echo "$config" | jq -r '.path')"

    if [ -z "$VIRTUAL_ENV" ]; then
        export VIRTUAL_ENV="$venv_path"
        export PATH="$VIRTUAL_ENV/bin:$PATH"
    fi

    if [ "$VIRTUAL_ENV" != "$venv_path" ]; then
        >&2 echo 'Error: already in a virtual environment'
        return 1
    fi

    local color_venv='%F{208}'  # Orange
    setup_prompt_base "$PROMPT_BASE$color_venv"'{$(prompt_venv)}'
}
