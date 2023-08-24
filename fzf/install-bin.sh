#!/bin/sh

set -eux

install_path=$1

echo "Compiling and installing nvim..."

src_path=$(dirname $0)/src
$src_path/install --bin
mv $src_path/bin/fzf $install_path/bin

