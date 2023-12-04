# TODO separate alias and module directories

function() {

    local modules_path="$(dirname "$(realpath "$1")")"
    local core_modules_path="$modules_path/core"
    local extra_modules_path="$modules_path/extra"

    for core_module_path in "$core_modules_path/"*".zsh"; do
        source "$core_module_path"
    done

    if [ -n "$ZSH_START_EXTRA_MODULES" ]; then
        for extra_module in ${(z)ZSH_START_EXTRA_MODULES}; do
            source "$extra_modules_path/$extra_module.zsh"
        done
    fi

    if [ -n "$ZSH_REQUESTED_EXTRA_MODULES" ]; then
        for extra_module in ${(z)ZSH_REQUESTED_EXTRA_MODULES}; do
            source "$extra_modules_path/$extra_module.zsh"
        done
    fi

    function _sm() {
        # Source extra module
        local extra_modules_path="$1"
        local extra_module="$2"

        local extra_module_path="$extra_modules_path/$extra_module.zsh"
        if [ ! -e "$extra_module_path" ]; then
            >&2 echo "zsh module not found at $extra_module_path"
            return 1
        fi

        if [[ " $ZSH_REQUESTED_EXTRA_MODULES " == *" $extra_module "* ]]; then
            return  # extra_module already sourced
        fi

        export ZSH_REQUESTED_EXTRA_MODULES="${ZSH_REQUESTED_EXTRA_MODULES+$ZSH_REQUESTED_EXTRA_MODULES }$extra_module"

        source "$extra_module_path"
    }
    alias sm="_sm \"$extra_modules_path\""

} "$0"
