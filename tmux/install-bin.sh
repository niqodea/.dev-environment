#!/bin/sh

# NOTE: for now we compile version 3.1c, as newer versions sometimes fail to escape character
# sequences sent by the terminal in response to a request for capabilities.
# Ref: https://github.com/tmux-plugins/tmux-sensible/issues/61#issuecomment-1691383965

set -eux

install_path=$1

echo "Compiling and installing tmux..."

repo_path=$(dirname $0)/bin-submodules/tmux
git submodule update --init $repo_path
cd $repo_path
sudo apt install --yes --no-install-recommends autoconf automake bison libevent-dev pkg-config
sh autogen.sh
./configure --prefix=$install_path
make
make install

