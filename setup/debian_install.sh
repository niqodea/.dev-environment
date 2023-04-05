#!/bin/bash

# Installing programs with apt-get
# We use apt-get for programs that are not trivial to install via a script

# Install Z shell
sudo apt-get --yes install zsh=5.8-3ubuntu1.1
# Make it default shell
# Ref: https://askubuntu.com/a/131838
sudo chsh -s $(which zsh)

# Install neovim
sudo apt-get --yes install neovim=0.4.3-3

# Installing programs in the submodules directory
# We use submodules for programs that offer a simple installation script

# Note: For this to work you must have cloned the github repo to your home folder as ~/dotfiles
repo_dir=dotfiles
submodules_dir=submodules
submodules_path=~/$repo_dir/$submodules_dir

# Pull submodules
git submodule update --init --recursive $submodules_path

# Install fuzzy finder
# This appends stuff to .zshrc, we redirect the new lines in an ad-hoc file for tidyness
mv ~/.zshrc ~/.zshrc.backup
> ~/.zshrc.fzf
ln -s ~/.zshrc.fzf ~/.zshrc
yes | $submodules_path/fzf/install --no-bash
mv ~/.zshrc.backup ~/.zshrc

# Install neovim plugins
nvim_plugins_path=~/.config/nvim/pack
tpope_plugins_path=$nvim_plugins_path/tpope/start
mkdir -p $tpope_plugins_path
rm -rf $tpope_plugins_path/vim-commentary
cp -r $submodules_path/vim-commentary $tpope_plugins_path
rm -rf $tpope_plugins_path/vim-surround
cp -r $submodules_path/vim-surround $tpope_plugins_path

