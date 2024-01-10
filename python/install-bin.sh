#!/bin/sh

set -eux

root="$(dirname "$(realpath "$0")")"
install_path="$1"

# Ref: https://docs.conda.io/projects/miniconda/en/latest/
conda_install_path="$HOME/.miniconda3"
conda_tmp_path='/tmp/miniconda.sh'
conda_url='https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh'
wget "$conda_url" -O "$conda_tmp_path"
sh "$conda_tmp_path" -b -p "$conda_install_path"
rm "$conda_tmp_path"
ln -s "$conda_install_path/bin/conda" "$install_path/bin/"

sudo apt install --yes --no-install-recommends python3.11 python3.11-venv

# Ref: https://python-poetry.org/docs/#installing-manually
poetry_venv_path="$HOME/.poetry-venv"
python3.11 -m venv "$poetry_venv_path"
"$poetry_venv_path/bin/pip" install poetry==1.7.1
ln -s "$poetry_venv_path/bin/poetry" "$install_path/bin/"

# Ref: https://github.com/pappasam/jedi-language-server#installation
jedi_venv_path="$HOME/.jedi-venv"
python3.11 -m venv "$jedi_venv_path"
"$jedi_venv_path/bin/pip" install jedi-language-server==0.41.2
ln -s "$jedi_venv_path/bin/jedi-language-server" "$install_path/bin/"

ropify_path="$root/bin-submodules/ropify"
ropify_venv_path="$HOME/.ropify-venv"
git submodule update --init "$ropify_path"
python3.11 -m venv "$ropify_venv_path"
"$ropify_venv_path/bin/pip" install "$ropify_path"
ln -s "$ropify_venv_path/bin/ropify" "$install_path/bin/"

sudo apt install --yes --no-install-recommends libc6-dev gcc
parser_path="$root/bin-submodules/tree-sitter-python"
# TODO: Find a way to centralize this definition, maybe .profile env?
parsers_install_path="$install_path/lib/tree-sitter"
parser_install_path="$parsers_install_path/python.so"
git submodule update --init "$parser_path"
mkdir -p "$parsers_install_path"
cc -o "$parser_install_path" -I"$parser_path/src" -shared -Os -fPIC "$parser_path/src/parser.c" "$parser_path/src/scanner.c"
