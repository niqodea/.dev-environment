#!/bin/bash

# Installing programs with apt-get
# We use apt-get for programs that are not trivial to install via a script

# Install Z shell
sudo apt-get --yes install zsh
# Make it default shell
# Ref: https://askubuntu.com/a/131838
sudo chsh -s $(which zsh)

# Install neovim
sudo apt-get --yes install neovim

# Installing programs in the submodules directory
# We use submodules for programs that offer a simple installation script

# Note: For this to work you must have cloned the github repo to your home folder as ~/dotfiles
repo_dir=dotfiles
submodules_dir=submodules
submodules_path=~/$repo_dir/$submodules_dir

# Pull submodules
git submodule update --recursive $submodules_path

# Install fuzzy finder
# This appends stuff to .zshrc, we redirect the new lines in an ad-hoc file for tidyness
mv ~/.zshrc ~/.zshrc.backup
> ~/.zshrc.fzf
ln -s ~/.zshrc.fzf ~/.zshrc
yes | $submodules_path/fzf/install --no-bash
mv ~/.zshrc.backup ~/.zshrc

