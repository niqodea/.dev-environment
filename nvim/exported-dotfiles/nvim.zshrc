alias v='nvim -c "LoadCore"'
alias vd='nvim -c "LoadDev"'

if [ -z "$NVIM_LASSO_ROOT" ] && [ -n "$ZSH_SESSION_ROOT" ]; then
    export NVIM_LASSO_ROOT=$ZSH_SESSION_ROOT
fi

if [ -z "$NVIM_DEFAULT_LANGUAGE" ] && [ -n "$ZSH_SESSION_DEFAULT_LANGUAGE" ]; then
    export NVIM_DEFAULT_LANGUAGE=$ZSH_SESSION_DEFAULT_LANGUAGE
fi

