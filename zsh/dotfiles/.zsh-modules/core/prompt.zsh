setopt PROMPT_SUBST

function setup_prompt_base() {
    export PROMPT_BASE="$1"

    local COLOR_OFF='%f'
    local SHELL_STATE='%#'
    export PROMPT="$PROMPT_BASE$COLOR_OFF$SHELL_STATE "
}

function burger_hash() {
    local input="$1"
    local left_bun_length="$2"
    local patty_hash_length="$3"
    local right_bun_length="$4"
    local padding_char="$5"

    local burger_length=$((left_bun_length + patty_hash_length + right_bun_length))
    if [[ "$burger_length" -eq "${#input}" ]]; then
        printf '%s' "$input"
        return
    fi
    if [[ "$burger_length" -gt "${#input}" ]]; then
        printf '%s' "$input"
        printf "%.s$padding_char" {1..$((burger_length - $#input))}
        return
    fi

    local left_bun="${input:0:$left_bun_length}"
    local right_bun="${input: -$right_bun_length}"
    local patty="${input:$left_bun_length: -$right_bun_length}"
    # Use integer as patty hash as it is more readable than hex
    local patty_hash=$(printf "%0${patty_hash_length}d" $((0x$(printf '%s' "$patty" | md5sum | cut -c1-8) % 10 ** $patty_hash_length)))

    printf '%s' "$left_bun$patty_hash$right_bun"
}

# TODO: Rename this function (does not necessarily compress)
# TODO: This will probably need to be refactored/implemented in a different language
#       if we want to support injectable burger parameters
function format_path() {
    # TODO: Maybe build string instead of printing as we go

    local input="$1"
    local num_top_components="$2"
    local num_bottom_components="$3"

    local max_components=$((num_top_components + num_bottom_components))

    if [[ "$input" == "$ZSH_ROOT" || "$input" == "$ZSH_ROOT/"* ]]; then
        printf "."
        local relpath="${input#$ZSH_ROOT}"
    elif [[ "$input" == "$HOME" || "$input" == "$HOME/"* ]]; then
        printf "~"
        local relpath="${input#$HOME}"
    else
        printf "/"
        local relpath="$input"
    fi

    printf "$leader"

    components=(${(s:/:)relpath})

    local left_bun_length=4
    local patty_hash_length=2
    local right_bun_length=4
    local padding_char=' '

    function get_component_burger() {
        local component="$1"
        local component_burger="$(burger_hash "$component" "$left_bun_length" "$patty_hash_length" "$right_bun_length" "$padding_char")"
        printf '%s' "$component_burger"
    }

    local burger_length=$((left_bun_length + patty_hash_length + right_bun_length))

    if [[ $#components -le "$max_components" ]]; then

        for component in $components; do
            component_burger="$(get_component_burger "$component")"
            printf '%s' "/$component_burger"
        done

        return
    fi

    for i in $(seq 1 $num_top_components); do
        component_burger="$(get_component_burger "$components[$i]")"
        printf '%s' "/$component_burger"
    done

    # Separate the top and bottom components with special character
    component_burger="$(get_component_burger "$components[-$num_bottom_components]")"
    printf '%s' ":$component_burger"

    for i in $(seq $((num_bottom_components - 1)) -1 1); do
        component_burger="$(get_component_burger "$components[-$i]")"
        printf '%s' "/$component_burger"
    done
}

function prompt_userhost() {
    local burger_user="$(burger_hash "$USER" 1 1 1)"
    local burger_host="$(burger_hash "$HOST" 1 1 1)"
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
