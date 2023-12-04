function () {
    if [ -n "${VIRTUAL_ENV+x}" ]; then
        return  # Virtual environment already set
    fi

    local virtual_env="$ZSH_ROOT/$WORKSPACE_CONFIG_DIR/venv"

    if [ ! -d "$virtual_env" ]; then
        >&2 echo "Virtual environment not found in $virtual_env"
        return 1
    fi

    export VIRTUAL_ENV="$virtual_env"
    export PATH="$virtual_env/bin:$PATH"
    setup_prompt_base "[venv]$PROMPT_BASE"
}

