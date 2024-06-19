setopt PROMPT_SUBST

function setup_prompt_base() {
    export PROMPT_BASE="$1"

    local COLOR_OFF='%f'
    local SHELL_STATE='%#'
    export PROMPT="$PROMPT_BASE$COLOR_OFF$SHELL_STATE "
}

# TODO: Rename this function (does not necessarily compress)
# TODO: This will probably need to be refactored/implemented in a different language
#       if we want to support injectable burger parameters
function format_path() {
    # TODO: Maybe build string instead of printing as we go

    local input="$1"
    local num_start_components="$2"
    local num_end_components="$3"

    local max_components=$((num_top_components + num_bottom_components))

    if [[ "$input" == "$ZSH_ROOT" || "$input" == "$ZSH_ROOT/"* ]]; then
        printf "."
        local relpath="${input#$ZSH_ROOT}"
    elif [[ "$input" == "$HOME" || "$input" == "$HOME/"* ]]; then
        printf "~"
        local relpath="${input#$HOME}"
    else
        printf "/"
        local relpath="${input#/}"
    fi

    if [ -z "$relpath" ]; then
        return
    fi

    local burgerized_relpath="$(hburger hash-path "$relpath" -s "$num_start_components" -e "$num_end_components" -p " ")"
    printf '%s' "$burgerized_relpath"
}

function prompt_userhost() {
    local burger_user="$(hburger hash "$USER" -l 1 -c 1 -r 1 -p " ")"
    local burger_host="$(hburger hash "$HOST" -l 1 -c 1 -r 1 -p " ")"
    printf "$burger_user@$burger_host"
}

function prompt_cwd() {
    local cwd="$PWD"
    local formatted_cwd="$(format_path "$cwd" 1 2)"
    local escaped_formatted_cwd="${formatted_cwd//\%/%%}"
    printf '%s' "$escaped_formatted_cwd"
}

function() {
    if [ -n "${PROMPT_BASE:+x}" ]; then
        return
    fi

    local color_userhost='%F{099}'  # Purple
    local color_cwd='%F{220}'  # Yellow

    setup_prompt_base "$color_userhost"'$(prompt_userhost)'"$color_cwd"'[$(prompt_cwd)]'
}
