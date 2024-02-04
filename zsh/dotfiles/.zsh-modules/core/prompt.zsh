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
        printf "%.s$padding_char" {1..$((burger_length - ${#input}))}
        return
    fi

    local left_bun="${input:0:$left_bun_length}"
    local right_bun="${input: -$right_bun_length}"
    local patty="${input:$left_bun_length: -$right_bun_length}"
    local patty_hash=$(printf '%s' "$patty" | md5sum | head -c "$patty_hash_length")

    printf '%s' "$left_bun$patty_hash$right_bun"
}

# TODO: Rename this function (does not necessarily compress)
# TODO: This will probably need to be refactored/implemented in a different language
#       if we want to support injectable burger parameters
function compress_path() {
    # TODO: Maybe build string instead of printing as we go

    local input="$1"
    local compression_radius="$2"

    local max_components=$((2 * $compression_radius + 1))

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
            component_burger=$(get_component_burger "$component")
            printf '%s' "/$component_burger"
        done
        
        # Pad to keep the compression length consistent
        for _ in $(seq 1 $(($max_components - $#components))); do
            printf "%.s$padding_char" {1..$((burger_length + 1))}
        done

        return
    fi

    for i in $(seq 1 $compression_radius); do
        component_burger=$(get_component_burger "$components[$i]")
        printf '%s' "/$component_burger"
    done

    # Marker for omitted directoriesc
    printf '%.s.' {1..$((1 + burger_length))}

    for i in $(seq $compression_radius -1 1); do
        component_burger=$(get_component_burger "$components[-$i]")
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
    local compressed_cwd="$(compress_path "$cwd" 1)"
    printf "$compressed_cwd"
}

function() {
    if [ -n "${PROMPT_BASE:+x}" ]; then
        return
    fi

    local color_userhost='%F{099}'  # Purple
    local color_cwd='%F{220}'  # Yellow

    setup_prompt_base "$color_userhost"'$(prompt_userhost)'"$color_cwd"'[$(prompt_cwd)]'
}
