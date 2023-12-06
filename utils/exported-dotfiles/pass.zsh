alias gpg-create-key='gpg --quick-generate-key "$USER" rsa3072 encr,sign 0'
alias gpg-decrypt='echo Success | gpg -e -r "$USER" | gpg -d --pinentry-mode loopback'

export PASSWORD_STORE_DIR="$ZSH_ROOT/.password-store"
alias pass-init='pass init "$USER"'
