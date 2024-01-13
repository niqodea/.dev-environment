#!/bin/sh

set -eu

root="$(dirname "$(realpath "$0")")"

usage="Usage: $0 [-p /install/path] [module1] [module2] [...]"

install_path="$HOME/.local"  # Default option value
while getopts "p:" opt; do
    case "$opt" in
        p) install_path="$OPTARG";;
        *) >&2 echo "$usage"; exit 1;;
    esac
done
shift "$((OPTIND-1))"  # positional arguments follow options

modules_path="$root/.modules.bc"

if [ "$#" -eq 0 ]; then
    # Install all modules
    modules=$(find "$modules_path/"* -maxdepth 0 -type d -exec basename {} \;)
else
    modules="$*"
fi

for module in $modules; do
    module_path="$modules_path/$module"

    if [ ! -d "$module_path" ]; then
        >&2 echo "Module $module not found"
        continue
    fi

    echo "Installing binary for module $module"
    "$module_path/install-bin.sh" "$install_path"

done
