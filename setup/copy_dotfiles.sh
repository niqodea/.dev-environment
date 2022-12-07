#!/bin/bash

# Find the dotfiles in the repo and copy them in the home directory
# Old dotfiles that would be overwritten are moved to a backup directory
# Note: For this to work you must have cloned the github repo to your home folder as ~/dotfiles/

# Use this directory to back up existing dotfiles before overwriting them
dotfiles_backup_dir=dotfiles_backup_$(date +%Y%m%d_%H%M%S)
mkdir ~/$dotfiles_backup_dir

dotfiles_repo_path=~/dotfiles/dotfiles

# Find all dotfiles in the repo
# Ref: https://unix.stackexchange.com/a/104803
dotfile_relpaths=$(cd $dotfiles_repo_path && find .[^.]* -type f -not -name "*.sample")
for dotfile_relpath in $dotfile_relpaths; do
	dotfile_repo_path=$dotfiles_repo_path/$dotfile_relpath
	dotfile_home_path=~/$dotfile_relpath

	# Check if a file with same name and different contents exists in home directory
	# Ref: https://stackoverflow.com/a/60886404
	# Ref: https://stackoverflow.com/a/12900693
	if [[ -e $dotfile_home_path || -L $dotfile_home_path ]] && ! cmp -s $dotfile_home_path $dotfile_repo_path; then
		# Back up existing file, preserving its directory structure
		mkdir -p ~/$dotfiles_backup_dir/$(dirname $dotfile_relpath)
		mv $dotfile_home_path ~/$dotfiles_backup_dir/$dotfile_relpath
	fi

	# Create directory containing dotfile if needed (e.g. ".config/nvim")
	mkdir -p $(dirname $dotfile_home_path)
	echo "Copying $dotfile_relpath in $HOME"
	cp $dotfile_repo_path $dotfile_home_path
done

# Check if back up directory is empty
# Ref: https://superuser.com/a/352290
if [ -z "$(ls -A ~/$dotfiles_backup_dir)" ]; then
	rmdir ~/$dotfiles_backup_dir
else
	echo "Backed up overwritten files in $HOME/$dotfiles_backup_dir"
fi

