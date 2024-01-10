#!/bin/sh

set -eux

root="$(dirname "$(realpath "$0")")"
install_path="$1"

echo 'Downloading and installing breadcrumbs...'
repo_path="$root/bin-submodules/breadcrumbs"
git submodule update --init "$repo_path"
cp "$repo_path/breadcrumbs" "$install_path/bin/"

# Building from source requires go to be installed, not worth it for now
echo 'Downloading and installing fzf...'
repo_path="$root/bin-submodules/fzf"
git submodule update --init "$repo_path"
# The fzf install script produces a symlink to the binary in the bin directory when fzf
# is already installed. Since this makes it hard to update fzf by rerunning the install
# script, we simply remove fzf from bin before running it.
rm -f "$install_path/bin/fzf"
"$repo_path/install" --bin
# We do not copy so that new versions can be installed by rerunning the install script
mv "$repo_path/bin/fzf" "$install_path/bin/"

echo 'Compiling and installing pass...'
repo_path="$root/bin-submodules/password-store"
git submodule update --init "$repo_path"
cd "$repo_path"
make install PREFIX="$install_path"

sudo apt install --yes --no-install-recommends python3.11 python3.11-venv

gdown_venv_path="$HOME/.gdown-venv"
python3.11 -m venv "$gdown_venv_path"
"$gdown_venv_path/bin/pip" install gdown==4.7.1
ln -s "$gdown_venv_path/bin/gdown" "$install_path/bin/"

ytdlp_venv_path="$HOME/.ytdlp-venv"
python3.11 -m venv "$ytdlp_venv_path"
"$ytdlp_venv_path/bin/pip" install yt-dlp==2023.12.30
ln -s "$ytdlp_venv_path/bin/yt-dlp" "$install_path/bin/"
