setopt PROMPT_SUBST

function setup_prompt_base() {
    export PROMPT_BASE="$1"

    local COLOR_OFF='%f'
    local SHELL_STATE='%#'
    export PROMPT="${PROMPT_BASE}${COLOR_OFF}${SHELL_STATE} "
}

function burger_hash() {
    local input="$1"
    local hash_patty_length="$2"

    local left_bun="${input:0:1}"
    local right_bun="${input: -1}"
    local patty="${input:1: -1}"
    local hash_patty=$(printf "%s" "$patty" | md5sum | head -c "$hash_patty_length")

    echo "${left_bun}${hash_patty}${right_bun}"
}

function prompt_userhost() {
    local burger_user=$(burger_hash "$USER" 2)
    local burger_host=$(burger_hash "$HOST" 2)
    echo "$burger_user@$burger_host"
}

function prompt_cwd() {
    local cwd="${PWD}"

    if [[ "$cwd" == "$ZSH_ROOT"* ]]; then
        local leader="."
        local relcwd="${cwd#$ZSH_ROOT}"
    elif [[ "$cwd" == "$HOME"* ]]; then
        local leader="~"
        local relcwd="${cwd#$HOME}"
    else
        local leader=" "
        local relcwd="${cwd}"
    fi

    printf "$leader"

    dirs=(${(s:/:)relcwd})

    local hash_patty_length=2
    local hash_burger_length=$((hash_patty_length + 2))

    if [[ $#dirs -le 5 ]]; then

        for dir in $dirs; do
            burger_dir=$(burger_hash "$dir" "$hash_patty_length")
            printf "/$burger_dir"
        done
        
        # Pad to keep the prompt length consistent
        for idx in $(seq 1 $((5 - $#dirs))); do
            printf '%.s-' {1..$hash_burger_length}
        done

        return
    fi

    # Put the first and last two directories in the prompt
    burger_dir_1=$(burger_hash "$dirs[1]" "$hash_patty_length")
    burger_dir_2=$(burger_hash "$dirs[2]" "$hash_patty_length")
    omitted_dirs=$(printf '%.s.' {1..$hash_burger_length})
    burger_dir_3=$(burger_hash "$dirs[-2]" "$hash_patty_length")
    burger_dir_4=$(burger_hash "$dirs[-1]" "$hash_patty_length")

    # Signal omitted directories with ellipses
    printf "/$burger_dir_1/$burger_dir_2/$omitted_dirs/$burger_dir_3/$burger_dir_4"
}

function() {
    if [ -n "${PROMPT_BASE:+x}" ]; then
        return
    fi

    local color_userhost='%F{099}'  # Purple
    local color_cwd='%F{220}'  # Yellow

    setup_prompt_base "${color_userhost}"'$(prompt_userhost)'"${color_cwd}"'[$(prompt_cwd)]'
}
