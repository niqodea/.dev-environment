#!/bin/sh

set -eux

install_path=$1

echo "Compiling and installing zsh..."

src_path=$(dirname $0)/src
git submodule update --init $src_path
cd $src_path
sudo apt install --yes --no-install-recommends autoconf gcc make ncurses-dev yodl
./Util/preconfig
./configure --prefix=$install_path
make
make install

