#!/bin/sh

set -eu

# Set modules directory as cwd using breadcrumbs
cd $(dirname $0)/.modules.bc

usage="Usage: $0 [-p /install/path] [module1] [module2] [...]"

install_path=$HOME/.local  # Default option value
while getopts "p:" opt; do
    case $opt in
        p) install_path=$OPTARG;;
        *) >&2 echo "$usage"; exit 1;;
    esac
done
shift $((OPTIND-1))  # positional arguments follow options

if [ $# -eq 0 ]; then
    # Install all modules
    modules=$(ls -d */ | tr -d "/" | xargs)
else
    modules="$@"
fi

for module in $modules; do

    if [ ! -d $module ]; then
        >&2 echo "Module $module not found"
        continue
    fi

    echo "Installing binary for module $module"
    $module/install-bin.sh $install_path

done
