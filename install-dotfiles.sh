#!/bin/sh

set -eu

root="$(dirname "$(realpath "$0")")"

modules_path="$root/.modules.bc"

if [ "$#" -eq 0 ]; then
    # Install all modules
    modules=$(find "$modules_path/"* -maxdepth 0 -type d -exec basename {} \;)
else
    modules="$*"
fi

backup_path="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

for module in $modules; do
    module_path="$modules_path/$module"

    if [ ! -d "$module_path" ]; then
        >&2 echo "Module $module not found"
        continue
    fi

    echo "Installing dotfiles for module $module"
    source_dotfiles_path="$module_path/dotfiles"
    dotfiles_submodules_path="$module_path/dotfiles-submodules"

    if [ -d "$dotfiles_submodules_path" ]; then
        echo "Pulling Git submodules for dotfiles of module $module"
        for submodule_path in "$dotfiles_submodules_path/"*; do
            submodule_canon_path="$(readlink -f "$submodule_path")"  # solve symlinks if any
            git submodule update --init "$submodule_canon_path"
        done
    fi

    for source_dotfile_path in "$source_dotfiles_path/."[!.]*; do
        target_dotfile_relpath="$(basename "$source_dotfile_path" | sed "s/%2F/\//g")"
        mkdir -p "$(dirname "$HOME"/"$target_dotfile_relpath")"  # rsync expects parent dir to exist

        if [ -d "$source_dotfile_path" ]; then
            rsync --archive --copy-unsafe-links --delete \
                --backup --backup-dir="$backup_path/$target_dotfile_relpath" \
                "$source_dotfile_path/" "$HOME/$target_dotfile_relpath"  # NOTE: trailing / is important
        else
            backup_dir="$backup_path/$(dirname "$target_dotfile_relpath")"

            if [ "${backup_dir#"${backup_dir%/.}"}" = "/." ]; then
                # Remove the trailing /. as rsync will break otherwise
                backup_dir="${backup_dir%/.}"
            fi

            rsync --archive --copy-unsafe-links \
                --backup --backup-dir="$backup_dir" \
                "$source_dotfile_path" "$HOME/$target_dotfile_relpath"
        fi
    done

    echo "Successfully installed dotfiles for module $module"
done

if [ -e "$backup_path" ]; then
    echo "Backed up overwritten dotfiles in $backup_path"
else
    echo 'All dotfiles already up-to-date, no files overwritten'
fi
