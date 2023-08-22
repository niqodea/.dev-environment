#!/bin/sh

set -eux

install_path=$HOME/.local

repo_root=$(git -C $(dirname $0) rev-parse --show-toplevel)
cd $repo_root

echo "Pulling submodules..."
core_submodules_path=$repo_root/submodules/core
git submodule update --init --recursive $core_submodules_path

