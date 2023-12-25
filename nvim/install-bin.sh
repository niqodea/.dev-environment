#!/bin/sh

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

# We need to install nodejs from the nodesource repository
# This is because the version of nodejs in the apt repository is too old
# Ref: https://deb.nodesource.com
sudo apt install --yes --no-install-recommends ca-certificates curl gnupg
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo 'deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main' | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update
sudo apt install --yes --no-install-recommends nodejs
