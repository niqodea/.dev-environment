#!/bin/sh

set -eux

# Ref: https://docs.conda.io/projects/miniconda/en/latest/
conda_install_path=$HOME/.miniconda3
conda_tmp_path=/tmp/miniconda.sh
conda_url="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
wget $conda_url -O $conda_tmp_path
sh $conda_tmp_path -b -p $conda_install_path
rm $conda_tmp_path
ln -s $conda_install_path/bin/conda ~/.local/bin

# Ref: https://python-poetry.org/docs/#installing-manually
poetry_venv_path=$HOME/.poetry-venv
conda create --prefix $poetry_venv_path --yes python=3.8
$poetry_venv_path/bin/pip install poetry==1.6.1
ln -s $poetry_venv_path/bin/poetry ~/.local/bin

# Ref: https://github.com/pappasam/jedi-language-server#installation
jedi_venv_path=$HOME/.jedi-venv
conda create --prefix $jedi_venv_path --yes python=3.8
$jedi_venv_path/bin/pip install jedi-language-server==0.41.1
ln -s $jedi_venv_path/bin/jedi-language-server ~/.local/bin
