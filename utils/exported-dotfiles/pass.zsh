export PASSWORD_STORE_DIR="$HOME/.password-store"

alias gpg-create-key='gpg --quick-generate-key "$USER" rsa3072 encr,sign 0'
alias gpg-decrypt='echo Success | gpg -e -r "$USER" | gpg -d --pinentry-mode loopback'

alias pass-init='pass init "$USER"'

function pass-shortcut-add() {
    item=$1

    if [ ! -e "$PASSWORD_STORE_DIR/$item.gpg" ]; then
        >&2 echo "Error: $item not in the password store."
        return 1
    fi

    local shortcuts_path="$ZSH_ROOT/.pass-shortcuts"
    echo "$item" >> "$shortcuts_path"
}

function pass-shortcut-show() {
    local shortcuts_path="$ZSH_ROOT/.pass-shortcuts"

    shortcut_idx="$1"
    item=$(head -n "$shortcut_idx" "$shortcuts_path" | tail -n 1)
    pass show "$item"
}
