#!/bin/sh

set -eux

install_path=$1

echo "Compiling and installing git..."

src_path=$(dirname $0)/src
git submodule update $src_path
cd $src_path
sudo apt install --yes --no-install-recommends asciidoc autoconf curl expat openssl perl python xmlto
make configure
./configure --prefix=$install_path
# Do not localize Git and do not install gitk/git-gui
make install install-man NO_GETTEXT=YesPlease NO_TCLTK=YesPlease

