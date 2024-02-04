setopt PROMPT_SUBST

function setup_prompt_base() {
    export PROMPT_BASE="$1"

    local COLOR_OFF='%f'
    local SHELL_STATE='%#'
    export PROMPT="$PROMPT_BASE$COLOR_OFF$SHELL_STATE "
}

function burger_hash() {
    local input="$1"
    local patty_hash_length="$2"

    local left_bun="${input:0:1}"
    local right_bun="${input: -1}"
    local patty="${input:1: -1}"
    local patty_hash=$(printf "%s" "$patty" | md5sum | head -c "$patty_hash_length")

    echo "$left_bun$patty_hash$right_bun"
}

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

    local patty_hash_length=2
    local burger_hash_length=$((patty_hash_length + 2))

    if [[ $#components -le "$max_components" ]]; then

        for component in $components; do
            burger_component=$(burger_hash "$component" "$patty_hash_length")
            printf "/$burger_component"
        done
        
        # Pad to keep the compression length consistent
        for _ in $(seq 1 $(($max_components - $#components))); do
            printf '%.s-' {1..$((burger_hash_length + 1))}
        done

        return
    fi

    for i in $(seq 1 $compression_radius); do
        burger_component=$(burger_hash "$components[$i]" "$patty_hash_length")
        printf "/$burger_component"
    done

    # Signal omitted directories with ellipses
    printf '/'
    printf '%.s.' {1..$((burger_hash_length + 1))}

    for i in $(seq $compression_radius -1 1); do
        burger_component=$(burger_hash "$components[-$i]" "$patty_hash_length")
        printf "/$burger_component"
    done
}

function prompt_userhost() {
    local burger_user="$(burger_hash "$USER" 2)"
    local burger_host="$(burger_hash "$HOST" 2)"
    printf "$burger_user@$burger_host"
}

function prompt_cwd() {
    local cwd="$PWD"
    local compressed_cwd="$(compress_path "$cwd" 2)"
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
