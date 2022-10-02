#!/bin/bash

# Install Z shell
sudo apt-get --yes install zsh
# Make it default shell
# Ref: https://askubuntu.com/a/131838
chsh -s $(which zsh)

