#!/bin/sh

set -eu

repo_root=$(dirname $0) # this script should be in repo root
cd $repo_root

if [ -n "${1+x}" ]; then
    install_path=$1
else
    install_path=$HOME/.local
fi

if [ -n "${2+x}" ]; then
    modules=$2
else
    # Consider all modules, i.e. all directories in repo root
    modules=$(ls -dm */ | tr -d "/" | tr -d " ")
fi

IFS=","
for module in $modules; do
    echo "Installing binary for module $module"
    sh $module/install-bin.sh $install_path
done

