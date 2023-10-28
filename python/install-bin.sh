#!/bin/sh

set -eux

root=$(dirname $0)
install_path=$1

# Ref: https://docs.conda.io/projects/miniconda/en/latest/
conda_install_path=$HOME/.miniconda3
conda_tmp_path=/tmp/miniconda.sh
conda_url="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
wget $conda_url -O $conda_tmp_path
sh $conda_tmp_path -b -p $conda_install_path
rm $conda_tmp_path
ln -s $conda_install_path/bin/conda $install_path/bin

# Ref: https://python-poetry.org/docs/#installing-manually
poetry_venv_path=$HOME/.poetry-venv
conda create --prefix $poetry_venv_path --yes python=3.8
$poetry_venv_path/bin/pip install poetry==1.6.1
ln -s $poetry_venv_path/bin/poetry $install_path/bin

# Ref: https://github.com/pappasam/jedi-language-server#installation
jedi_venv_path=$HOME/.jedi-venv
conda create --prefix $jedi_venv_path --yes python=3.8
$jedi_venv_path/bin/pip install jedi-language-server==0.41.1
ln -s $jedi_venv_path/bin/jedi-language-server $install_path/bin

ropify_venv_path=$HOME/.ropify-venv
conda create --prefix $ropify_venv_path --yes python=3.10
$ropify_venv_path/bin/pip install $root/bin-submodules/ropify
ln -s $ropify_venv_path/bin/ropify $install_path/bin

sudo apt install --yes --no-install-recommends libc6-dev gcc
python_parser_path=$root/bin-submodules/tree-sitter-python
# TODO: Find a way to centralize this definition, maybe .profile env?
parsers_install_path=$install_path/lib/tree-sitter
python_parser_install_path=$parsers_install_path/python.so
git submodule update --init $python_parser_path
mkdir -p $parsers_install_path
cc -o $python_parser_install_path -I$python_parser_path/src -shared -Os -fPIC $python_parser_path/src/parser.c $python_parser_path/src/scanner.c
