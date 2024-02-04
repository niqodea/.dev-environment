function prompt_git_info() {
    # TODO: Maybe build string instead of printing as we go

    local hash_burger_length=7  # Same as git default for short SHA
    local patty_hash_length=$((hash_burger_length - 2))

    local git_dir=$(git rev-parse --git-dir 2> /dev/null)
    if [ -z "$git_dir" ]; then
        printf '%.s-' {1..$((hash_burger_length + 2))}
        return
    fi

    if [ -d "$git_dir/rebase-merge" ] || [ -d "$git_dir/rebase-apply" ]; then
        printf 'B'
    elif [ -f "$git_dir/MERGE_HEAD" ]; then
        printf 'M'
    elif [ -f "$git_dir/BISECT_LOG" ]; then
        printf 'S'
    elif [ -f "$git_dir/CHERRY_PICK_HEAD" ]; then
        printf 'C'
    elif [ -f "$git_dir/REVERT_HEAD" ]; then
        printf 'R'
    else
        printf '.'
    fi

    local current_ref=$(git rev-parse --abbrev-ref HEAD)
    if [ "$current_ref" = "HEAD" ]; then
        # Detached HEAD, print the short SHA
        printf ' '  # Detached
        printf '%s' "$(git rev-parse --short HEAD)"
    else
        # HEAD points to branch, print branch's name burger hash
        printf '>'  # Attached
        local current_branch="$current_ref"
        printf '%s' "$(burger_hash "$current_branch" "$patty_hash_length")"
    fi
}


function () {
    if [ "$ZSH_GIT_PROMPT_SETUP" = 'true' ]; then
        return
    fi
    export ZSH_GIT_PROMPT_SETUP='true'

    local color_git='%F{034}'  # Green
    setup_prompt_base "$PROMPT_BASE$color_git"'($(prompt_git_info))'
}
