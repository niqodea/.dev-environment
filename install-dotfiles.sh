#!/bin/sh

set -eu

usage="Usage: $0 [-a] [-m] [-o] [module1,...,moduleN]"
if [ $# -eq 0 ]; then >&2 echo "$usage"; exit 1; fi

cd $(dirname $0)/.gitroot

# Default option values
install_all_modules=false
install_other=false

while getopts "amo" opt; do
    case $opt in
        a) install_other=true; install_all_modules=true;;
        m) install_all_modules=true;;
        o) install_other=true;;
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

backup_path=$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)

install_dotfiles() {
    source_dotfiles_path=$1

    for source_dotfile_path in $source_dotfiles_path/.[!.]*; do
        target_dotfile_relpath=$(basename $source_dotfile_path | sed "s/%2F/\//g")
        mkdir -p $(dirname $HOME/$target_dotfile_relpath)  # rsync expects parent dir to exist

        if [ -d $source_dotfile_path ]; then
            rsync --archive --copy-unsafe-links --delete \
                --backup --backup-dir=$backup_path/$target_dotfile_relpath \
                $source_dotfile_path/ $HOME/$target_dotfile_relpath  # NOTE: trailing / is important
        else
            backup_dir=$backup_path/$(dirname $target_dotfile_relpath)

            if [ "${backup_dir#${backup_dir%/.}}" = "/." ]; then
                # Remove the trailing /. as rsync will break otherwise
                backup_dir="${backup_dir%/.}"
            fi

            rsync --archive --copy-unsafe-links \
                --backup --backup-dir=$backup_dir \
                $source_dotfile_path $HOME/$target_dotfile_relpath
        fi
    done
}

IFS=","
for module in $modules; do

    dotfiles_path=$module/dotfiles

    if [ ! -d $dotfiles_path ]; then
        >&2 echo "Dotfiles directory not found for module $module"
        continue
    fi

    echo "Installing dotfiles for module $module"

    dotfiles_submodules_path=$module/dotfiles-submodules
    if [ -d $dotfiles_submodules_path ]; then
        echo "Pulling Git submodules for dotfiles of module $module"
        for submodule_path in $dotfiles_submodules_path/*; do
            submodule_canon_path=$(readlink -f $submodule_path)  # solve symlinks if any
            git submodule update --init $submodule_canon_path
        done
    fi

    install_dotfiles $dotfiles_path
    echo "Successfully installed dotfiles for module $module"
done

if [ $install_other = true ]; then
    echo "Installing other dotfiles"

    install_dotfiles .other-dotfiles
fi

if [ -e $backup_path ]; then
    echo "Backed up overwritten files in $backup_path"
fi

