#!/bin/sh

set -eu

# Set modules directory as cwd using breadcrumbs
cd $(dirname $0)/.modules.bc

if [ $# -eq 0 ]; then
    # Install all modules
    modules=$(ls -d */ | tr -d "/" | xargs)
else
    modules="$@"
fi

backup_path=$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)

for module in $modules; do

    if [ ! -d $module ]; then
        >&2 echo "Module $module not found"
        continue
    fi

    echo "Installing dotfiles for module $module"
    source_dotfiles_path=$module/dotfiles
    dotfiles_submodules_path=$module/dotfiles-submodules

    if [ -d $dotfiles_submodules_path ]; then
        echo "Pulling Git submodules for dotfiles of module $module"
        for submodule_path in $dotfiles_submodules_path/*; do
            submodule_canon_path=$(readlink -f $submodule_path)  # solve symlinks if any
            git submodule update --init $submodule_canon_path
        done
    fi

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

    echo "Successfully installed dotfiles for module $module"
done

if [ -e $backup_path ]; then
    echo "Backed up overwritten dotfiles in $backup_path"
else
    echo "All dotfiles already up-to-date, no files overwritten"
fi
