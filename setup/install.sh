#!/bin/sh

set -eux

install_path=$HOME/.local

repo_root=$(git -C $(dirname $0) rev-parse --show-toplevel)
cd $repo_root

echo "Pulling submodules..."
core_submodules_path=$repo_root/submodules/core
git submodule update --init --recursive $core_submodules_path

echo "Compiling and installing git..."
cd $core_submodules_path/git
sudo apt install --yes --no-install-recommends asciidoc autoconf curl expat openssl perl python xmlto
make configure
./configure --prefix=$install_path
# Do not localize Git and do not install gitk/git-gui
make install install-man NO_GETTEXT=YesPlease NO_TCLTK=YesPlease

echo "Compiling and installing zsh..."
cd $core_submodules_path/zsh
sudo apt install --yes --no-install-recommends autoconf gcc make ncurses-dev yodl
./Util/preconfig
./configure --prefix=$install_path
make
make install

echo "Compiling and installing tmux..."
cd $core_submodules_path/tmux
sudo apt install --yes --no-install-recommends autoconf automake bison libevent-dev pkg-config
sh autogen.sh
./configure --prefix=$install_path
make
make install

echo "Compiling and installing nvim..."
cd $core_submodules_path/neovim
sudo apt install --yes --no-install-recommends cmake curl gettext ninja-build unzip
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$install_path
make install

