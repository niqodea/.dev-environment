function () {
    if [ "$ZSH_GIT_PROMPT_SETUP" = 'true' ]; then
        return
    fi

    export ZSH_GIT_PROMPT_SETUP='true'

	local COLOR_GIT='%F{034}'  # Green
    local GIT_INFO='$(git rev-parse --is-inside-work-tree &> /dev/null && (git symbolic-ref --short -q HEAD || git rev-parse --short HEAD))'

	setup_prompt_base "${PROMPT_BASE}${COLOR_GIT}(${GIT_INFO})"
}
