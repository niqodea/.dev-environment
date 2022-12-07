#!/bin/bash

# Find the dotfiles in the repo and copy them in the home directory
# Old dotfiles that would be overwritten are moved to a backup directory
# Note: For this to work you must have cloned the github repo to your home folder as ~/dotfiles/

# Use this directory to back up existing dotfiles before overwriting them
dotfiles_backup_dir=dotfiles_backup_$(date +%Y%m%d_%H%M%S)
mkdir ~/$dotfiles_backup_dir

repo_dir=dotfiles
dotfiles_dir=dotfiles

# Find all dotfiles in the repo
# Ref: https://unix.stackexchange.com/a/104803
dotfile_relpaths=$(cd $dotfiles_repo_path && find .[^.]* -type f -not -name "*.sample")
for dotfile_relpath in $dotfile_relpaths; do
	# Check if a file with same name already exists
	if [ -e ~/$dotfile_relpath ]; then
		# Back up existing file
		mkdir -p ~/$dotfiles_backup_dir/$(dirname $dotfile_relpath)
		mv ~/$dotfile_relpath ~/$dotfiles_backup_dir/$dotfile_relpath
	fi

	# Create directory containing dotfile if needed (e.g. ".config/nvim")
	mkdir -p ~/$(dirname $dotfile_relpath)
	echo "Copying $dotfile_relpath in $HOME"
	cp ~/$repo_dir/$dotfiles_dir/$dotfile_relpath ~/$dotfile_relpath
done

# Check if back up directory is empty
# Ref: https://superuser.com/a/352290
if [ -z "$(ls -A ~/$dotfiles_backup_dir)" ]; then
	rmdir ~/$dotfiles_backup_dir
else
	echo "Backed up overwritten files in $HOME/$dotfiles_backup_dir"
fi

