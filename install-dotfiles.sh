#!/bin/sh

set -eu

repo_root=$(dirname $0) # this script should be in repo root

backup_path=$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)

while [ $# -gt 0 ]; do
    module=$1
    source_dotfiles_path=$repo_root/$module/dotfiles

    if [ ! -d $source_dotfiles_path ]; then
        >&2 echo "Dotfiles directory not found for module $module"
        exit 1
    fi
    
    echo "Installing dotfiles for module $module"

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

    shift

done

if [ -e $backup_path ]; then
	echo "Backed up overwritten files in $backup_path"
fi

