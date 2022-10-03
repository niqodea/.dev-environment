#!/bin/bash

# Discover the dotfiles
# Note: For this to work you must have cloned the github repo to your home folder as ~/dotfiles/
# Ref: https://superuser.com/a/830604
repo_dir_path=~/dotfiles
dotfiles_dir=dotfiles
dotfile_regex=.[^.]*
for f in $repo_dir_path/$dotfiles_dir/$dotfile_regex; do
	echo "Copying $f"
	cp -r $f ~
done

