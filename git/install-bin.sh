#!/bin/sh

set -eux

root="$(dirname "$(realpath "$0")")"
install_path="$1"

echo 'Compiling and installing git...'

repo_path="$root/bin-submodules/git"
git submodule update --init "$repo_path"
cd "$repo_path"
# Ref: https://stackoverflow.com/a/65876436
sudo apt install --yes --no-install-recommends asciidoc autoconf curl expat libcurl4-openssl-dev openssl perl python xmlto
make configure
./configure --prefix="$install_path"
# Do not localize Git and do not install gitk/git-gui
make install install-man NO_GETTEXT="YesPlease" NO_TCLTK="YesPlease"
