for file in "$HOME/.profile.d/"*; do
    source "$file"
done

export PATH="$HOME/.local/bin:$PATH"
export WORKSPACE_CONFIG_DIR=".workspace-config"
