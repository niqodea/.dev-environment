#!/bin/sh

set -eux

install_path=$1

echo "Compiling and installing tmux..."

src_path=$(dirname $0)/src
git submodule update --init $src_path
cd $src_path
sudo apt install --yes --no-install-recommends autoconf automake bison libevent-dev pkg-config
sh autogen.sh
./configure --prefix=$install_path
make
make install

