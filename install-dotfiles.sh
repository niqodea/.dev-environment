#!/bin/sh

set -eu

cd $(dirname $0)/.gitroot

# Reorder arguments to first process options
args=$(getopt -o amo -n "\\$0" -- "$@")
eval set -- $args

# Default option values
install_all_modules=false
install_other=false

while [ $1 != "--" ]; do
    case $1 in
        -a) install_other=true; install_all_modules=true; shift 1;;
        -m) install_all_modules=true; shift 1;;
        -o) install_other=true; shift 1;;
        *) >&2 echo "Unhandled option: $1"; exit 1;;
    esac
done
shift

if [ $install_all_modules = true ]; then
    # Get all non-dot subdirectories in root as a comma-separated string
    modules=$(ls -dm */ | tr -d "/" | tr -d " ")
else
    modules=${1+$1}  # empty string if unset
fi

backup_path=$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)

install_dotfiles() {
    source_dotfiles_path=$1

    if [ ! -d $source_dotfiles_path ]; then
        >&2 echo "Dotfiles directory does not exist: $source_dotfiles_path"
        exit 1
    fi

    git submodule update --init --recursive $source_dotfiles_path

    for source_dotfile_path in $source_dotfiles_path/.[!.]*; do
        target_dotfile_relpath=$(basename $source_dotfile_path | sed "s/%2F/\//g")

        if [ -d $source_dotfile_path ]; then
            rsync --archive --backup --delete --backup-dir=$backup_path/$target_dotfile_relpath \
                $source_dotfile_path/ $HOME/$target_dotfile_relpath  # NOTE: trailing / is important
        else
            backup_dir=$backup_path/$(dirname $target_dotfile_relpath)

            if [ "${backup_dir#${backup_dir%/.}}" = "/." ]; then
                # Remove the trailing /. as rsync will break otherwise
                backup_dir="${backup_dir%/.}"
            fi

            rsync --archive --backup --backup-dir=$backup_dir \
                $source_dotfile_path $HOME/$target_dotfile_relpath
        fi
    done
}

IFS=","
for module in $modules; do
    source_dotfiles_path=$module/dotfiles

    if [ ! -d $source_dotfiles_path ]; then
        >&2 echo "Dotfiles directory not found for module $module"
        exit 1
    fi
    
    echo "Installing dotfiles for module $module"

    install_dotfiles $source_dotfiles_path

done

if [ $install_other = true ]; then
    echo "Installing other dotfiles"

    install_dotfiles .other-dotfiles
fi

if [ -e $backup_path ]; then
    echo "Backed up overwritten files in $backup_path"
fi

