function format_venv_path() {

    local venv_path="$1"

    if [ -z "$venv_path" ]; then
        printf '%s' "X/ "  # matches structure generated below
        return
    fi

    if [[ "$venv_path" == *"$WORKSPACE_CONFIG_DIR/venv" ]]; then
        local base_path="${venv_path%$WORKSPACE_CONFIG_DIR/venv}"
        local postfix="."
    elif [[ "$venv_path" == *"/.venv"  ]]; then
        local base_path="${venv_path%/.venv}"
        local postfix="v"
    else
        local base_path="$venv_path"
        local postfix=" "
    fi

    local prefix="$(format_path "$base_path" 1 1)"

    printf '%s' "$prefix/$postfix"

}


function prompt_venv() {
    local venv_path="$VIRTUAL_ENV"
    local venv_formatted_path="$(format_venv_path "$venv_path")"
    local escaped_venv_formatted_path="${venv_formatted_path//\%/%%}"
    printf '%s' "$escaped_venv_formatted_path"
}


function () {
    if [ "$ZSH_VIRTUAL_ENV_PROMPT_SETUP" = 'true' ]; then
        return
    fi
    export ZSH_VIRTUAL_ENV_PROMPT_SETUP='true'

    local color_venv='%F{208}'  # Orange
    setup_prompt_base "$PROMPT_BASE$color_venv"'{$(prompt_venv)}'
}

