#!/bin/sh

set -eux

install_path=$1

echo "Compiling and installing zsh..."

repo_path=$(dirname $0)/bin-submodules/zsh
git submodule update --init $repo_path
cd $repo_path
sudo apt install --yes --no-install-recommends autoconf gcc make ncurses-dev yodl
./Util/preconfig
./configure --prefix=$install_path
make
make install
