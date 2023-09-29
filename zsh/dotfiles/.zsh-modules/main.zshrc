# TODO separate alias and module directories

function() {
    
    local zsh_modules_path=$(dirname $1)
    local zsh_core_modules_path=$zsh_modules_path/core
    local zsh_extra_modules_path=$zsh_modules_path/extra

    for core_module_path in $zsh_core_modules_path/*.zshrc; do
        source $core_module_path
    done

    if [ -n "$ZSH_SESSION_MODULES" ]; then
        for session_module in ${(z)ZSH_SESSION_MODULES}; do
            source $zsh_extra_modules_path/$session_module.zshrc
        done
    fi

    if [ -n "$ZSH_EXTRA_MODULES" ]; then
        for extra_module in ${(z)ZSH_EXTRA_MODULES}; do
            source $zsh_extra_modules_path/$extra_module.zshrc
        done
    fi

    function _sm() {
        # Source extra module
        local extra_modules_path=$1
        local extra_module=$2

        local extra_module_path=$zsh_extra_modules_path/$extra_module.zshrc
        if [ ! -e $extra_module_path ]; then
            >&2 echo "zsh module not found at $extra_module_path"
            return 1
        fi

        if [[ " $ZSH_EXTRA_MODULES " == *" $extra_module "* ]]; then
            return  # extra_module already sourced
        fi

        export ZSH_EXTRA_MODULES="${ZSH_EXTRA_MODULE+$ZSH_EXTRA_MODULES }$extra_module"

        source $extra_module_path
    }
    alias sm="_sm $zsh_extra_modules_path"

} $0
