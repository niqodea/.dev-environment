alias v='nvim -c "LoadCore"'
alias vd='nvim -c "LoadDev"'
alias vdpy='vd -c "LspStartPython"'

if [ -z "$NVIM_LASSO_ROOT" ]; then
    export NVIM_LASSO_ROOT=$ZSH_SESSION_ROOT
fi

