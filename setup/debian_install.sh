#!/bin/bash

# Install neovim
sudo apt-get --yes install neovim

# Install Z shell
sudo apt-get --yes install zsh
# Make it default shell
# Ref: https://askubuntu.com/a/131838
chsh -s $(which zsh)

# Install fzf
sudo apt-get install fzf

