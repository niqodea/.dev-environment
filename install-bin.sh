#!/bin/sh

set -eu

# Reorder arguments to first process options
args=$(getopt -o p: -n "\\$0" -- "$@")
eval set -- $args

# Default option values
install_path=$HOME/.local

while [ $1 != "--" ]; do
    case $1 in
        -p) install_path="$2"; shift 2;;
        *) >&2 echo "Unhandled option: $1"; exit 1;;
    esac
done
shift

repo_root=$(dirname $0) # this script should be in repo root
cd $repo_root

if [ -n "${1+x}" ]; then
    modules=$1
else
    # Consider all modules, i.e. all directories in repo root
    modules=$(ls -dm */ | tr -d "/" | tr -d " ")
fi

IFS=","
for module in $modules; do
    echo "Installing binary for module $module"
    sh $module/install-bin.sh $install_path
done

