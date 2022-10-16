#!/bin/bash

# Note: For this to work you must have cloned the github repo to your home folder as ~/dotfiles

repo_dir=dotfiles
submodules_dir=submodules
submodules_path=~/$repo_dir/$submodules_dir

# Install neovim
sudo apt-get --yes install neovim

# Install Z shell
sudo apt-get --yes install zsh
# Make it default shell
# Ref: https://askubuntu.com/a/131838
sudo chsh -s $(which zsh)

# Install fzf
# The .zshrc in this repo already sources ~/.fzf.zsh if it exists, so no rc update is required
$submodules_path/fzf/install --key-bindings --completion --no-update-rc --no-bash

