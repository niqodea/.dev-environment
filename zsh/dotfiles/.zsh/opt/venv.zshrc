function () {
    if [ -n "${VIRTUAL_ENV+x}" ]; then
        return  # Virtual environment already set
    fi

    if [ -n "${ZSH_SESSION_ROOT+x}" ]; then
        local virtual_env=$ZSH_SESSION_ROOT/.venv
    else
        local virtual_env=$HOME/.venv
    fi

    if [ ! -e $virtual_env ]; then
        >&2 echo "Virtual environment not found in $virtual_env"
        return 1
    fi

    export VIRTUAL_ENV=$virtual_env
    export PATH=$virtual_env/bin:$PATH
    setup_prompt_base "[venv]$PROMPT_BASE"
}

