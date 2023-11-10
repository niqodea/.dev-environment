#!/bin/sh

set -eu

usage="Usage: $0 [-a] [-p /install/path] [module1,...,moduleN]"
if [ $# -eq 0 ]; then >&2 echo "$usage"; exit 1; fi

# Set modules directory as cwd using breadcrumbs
cd $(dirname $0)/.modules.bc

# Default option values
install_all_modules=false
install_path=$HOME/.local

while getopts "ap:" opt; do
    case $opt in
        a) install_all_modules=true;;
        p) install_path=$OPTARG;;
        *) >&2 echo "$usage"; exit 1;;
    esac
done
shift $((OPTIND-1))  # positional arguments follow options
if [ $# -gt 1 ]; then echo "$usage"; exit 1; fi

if [ $install_all_modules = true ]; then
    # Get all non-dot subdirectories in root as a comma-separated string
    modules=$(ls -dm */ | tr -d "/" | tr -d " ")
else
    modules=${1+$1}  # empty string if unset
fi

mkdir -p $install_path/bin

IFS=","
for module in $modules; do
    echo "Installing binary for module $module"
    $module/install-bin.sh $install_path
done

