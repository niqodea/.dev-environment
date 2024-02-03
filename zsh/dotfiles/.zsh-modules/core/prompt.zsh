setopt PROMPT_SUBST

function setup_prompt_base() {
    export PROMPT_BASE="$1"

    local COLOR_OFF='%f'
    local SHELL_STATE='%#'
    export PROMPT="${PROMPT_BASE}${COLOR_OFF}${SHELL_STATE} "
}

function burger_encode() {
    local input="$1"

    local left_bun="${input:0:1}"
    local right_bun="${input: -1}"
    local patty="${input:1: -1}"
    local hash_patty=$(printf "%s" "$patty" | md5sum | head -c 2)

    echo "${left_bun}${hash_patty}${right_bun}"
}

function prompt_userhost() {
    local burger_user=$(burger_encode "$USER")
    local burger_host=$(burger_encode "$HOST")
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

    if [[ $#dirs -le 5 ]]; then

        for dir in $dirs; do
            burger_dir=$(burger_encode "$dir")
            printf "/$burger_dir"
        done
        
        # Pad to keep the prompt length consistent
        for idx in $(seq 1 $((5 - $#dirs))); do
            printf '-----'  # 1 + length of burger encode
        done

        return
    fi

    # Put the first and last two directories in the prompt
    burger_dir_1=$(burger_encode "$dirs[1]")
    burger_dir_2=$(burger_encode "$dirs[2]")
    burger_dir_3=$(burger_encode "$dirs[-2]")
    burger_dir_4=$(burger_encode "$dirs[-1]")

    # Signal omitted directories with ellipses
    printf "/$burger_dir_1/$burger_dir_2/..../$burger_dir_3/$burger_dir_4"
}

if [ -z "${PROMPT_BASE:+x}" ]; then
    local COLOR_USERHOST='%F{099}'  # Purple
    local COLOR_CWD='%F{220}'  # Yellow

    setup_prompt_base "${COLOR_USERHOST}"'$(prompt_userhost)'"${COLOR_CWD}"'[$(prompt_cwd)]'
fi
