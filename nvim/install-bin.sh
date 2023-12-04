#!/bin/sh

# TODO add installation of nodejs v16.x+ for copilot.vim
# (the version of nodejs in the apt repository is too old)

set -eux

root="$(dirname "$(realpath "$0")")"
install_path="$1"

echo 'Compiling and installing nvim...'

repo_path="$root/bin-submodules/neovim"
git submodule update --init "$repo_path"
cd "$repo_path"
sudo apt install --yes --no-install-recommends cmake curl gettext libtool-bin ninja-build pkg-config unzip
make CMAKE_BUILD_TYPE="Release" CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=\"$install_path\""
make install
