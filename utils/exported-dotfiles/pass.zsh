export PASSWORD_STORE_DIR=$ZSH_ROOT/.password-store

function pass-shortcut-setup() {
    local shortcuts_path=$PASSWORD_STORE_DIR/shortcuts
    mkdir $shortcuts_path
    # Set up breadcrumbs (ref: https://github.com/niqodea/breadcrumbs)
    breadcrumbs -s $PASSWORD_STORE_DIR -t $shortcuts_path -n "password-store"
}

function pass-shortcut-add() {
    item=$1

    if [ ! -e $PASSWORD_STORE_DIR/$item.gpg ]; then
        >&2 echo "Error: $item not in the password store."
        return 1
    fi

    local shortcuts_path=$PASSWORD_STORE_DIR/shortcuts

    shortcut_idx=1
    while [ -e $shortcuts_path/$shortcut_idx.gpg ]; do
        shortcut_idx=$((shortcut_idx + 1))
    done

    ln -s .password-store.bc/$item.gpg $shortcuts_path/$shortcut_idx.gpg
}

function pass-shortcut-show() {
    shortcut_idx=$1
    pass show shortcuts/$shortcut_idx
}
