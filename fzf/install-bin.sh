#!/bin/sh

set -eux

install_path=$1

echo "Compiling and installing nvim..."

repo_path=$(dirname $0)/bin-submodules/fzf
git submodule update --init $repo_path
$repo_path/install --bin
mv $repo_path/bin/fzf $install_path/bin
