#!/bin/sh

set -eu

cd $(dirname $0)/.gitroot

# Reorder arguments to first process options
args=$(getopt -o ap: -n "\\$0" -- "$@")
eval set -- $args

# Default option values
install_all_modules=false
install_path=$HOME/.local

while [ $1 != "--" ]; do
    case $1 in
        -a) install_all_modules=true; shift 1;;
        -p) install_path="$2"; shift 2;;
        *) >&2 echo "Unhandled option: $1"; exit 1;;
    esac
done
shift

if [ $install_all_modules = true ]; then
    # Get all non-dot subdirectories in root as a comma-separated string
    modules=$(ls -dm */ | tr -d "/" | tr -d " ")
else
    modules=$1
fi

IFS=","
for module in $modules; do
    echo "Installing binary for module $module"
    sh $module/install-bin.sh $install_path
done

