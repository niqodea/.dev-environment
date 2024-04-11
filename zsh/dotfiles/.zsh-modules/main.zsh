if [ -z "$ZSH_MODULES_PATH" ]; then
    export ZSH_MODULES_PATH="$(dirname "$0")"
fi

if [ -z "$ZSH_EXTRA_MODULES" ]; then
    export ZSH_EXTRA_MODULES='{}'
fi

function _activate_extra_module() {
    local extra_module="$1"
    
    if [ -n "$2" ]; then
        local config="$2"
    else
        local config='{}'  # empty config
    fi

    if echo "$ZSH_EXTRA_MODULES" | jq -e ".$extra_module" > /dev/null ; then
        >&2 echo "Error: zsh module $extra_module already activated"
        return 1
    fi

    export ZSH_EXTRA_MODULES="$(echo "$ZSH_EXTRA_MODULES" | jq -c ".$extra_module = $config")"
    source "$ZSH_MODULES_PATH/extra/$extra_module.zsh"
}

function() {
    local core_modules_path="$ZSH_MODULES_PATH/core"
    for core_module_path in "$core_modules_path/"*".zsh"; do
        source "$core_module_path"
    done

    local extra_modules_path="$ZSH_MODULES_PATH/extra"
    for extra_module in $(echo "$ZSH_EXTRA_MODULES" | jq -r 'keys_unsorted[]'); do
        source "$extra_modules_path/$extra_module.zsh"
    done
}
