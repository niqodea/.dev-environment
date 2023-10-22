#!/bin/sh

# TODO add installation of nodejs v16.x+ for copilot.vim
# (the version of nodejs in the apt repository is too old)

set -eux

root=$(dirname $0)
install_path=$1

echo "Compiling and installing nvim..."

repo_path=$root/bin-submodules/neovim
git submodule update --init $repo_path
cd $repo_path
sudo apt install --yes --no-install-recommends cmake curl gettext libtool-bin ninja-build pkg-config unzip
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$install_path"
make install


# Compile and install tree-sitter parsers
sudo apt install --yes --no-install-recommends libc6-dev gcc

parsers_install_path=$HOME/.local/share/nvim/site/parser
mkdir -p $parsers_install_path

python_parser_path=$root/bin-submodules/tree-sitter-python
python_parser_install_path=$parsers_install_path/python.so
git submodule update --init $python_parser_path
cc -o $python_parser_install_path -I$python_parser_path/src -shared -Os -fPIC $python_parser_path/src/parser.c $python_parser_path/src/scanner.c
