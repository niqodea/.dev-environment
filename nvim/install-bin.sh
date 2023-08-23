#!/bin/sh

set -eux

install_path=$1

echo "Compiling and installing nvim..."

src_path=$(dirname $0)/src
git submodule update --init $src_path
cd $src_path
sudo apt install --yes --no-install-recommends cmake curl gettext libtool-bin ninja-build pkg-config unzip
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$install_path
make install

