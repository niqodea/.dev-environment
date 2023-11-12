#!/bin/sh

set -eux

install_path=$1

echo "Downloading and installing breadcrumbs..."
repo_path=$(dirname $0)/bin-submodules/breadcrumbs
cp $repo_path/breadcrumbs $install_path/bin/

# Building from source requires go to be installed, not worth it for now
echo "Downloading and installing fzf..."
repo_path=$(dirname $0)/bin-submodules/fzf
git submodule update --init $repo_path
$repo_path/install --bin
mv $repo_path/bin/fzf $install_path/bin/

echo "Compiling and installing pass..."
repo_path=$(dirname $0)/bin-submodules/password-store
git submodule update --init $repo_path
cd $repo_path
make install PREFIX=$install_path
