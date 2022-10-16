#!/bin/bash

# Install neovim
sudo apt-get --yes install neovim

# Install Z shell
sudo apt-get --yes install zsh
# Make it default shell
# Ref: https://askubuntu.com/a/131838
sudo chsh -s $(which zsh)

