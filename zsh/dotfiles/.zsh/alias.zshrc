# Listing files
alias ls="ls --color"  # Add colors to ls
alias ll="ls -l -h"  # -h is for human-readable file size
alias la="ls -a"

# Easier navigation in directories
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Size of files
alias duh="du -hs"

# Find
alias f="find ."
alias fn="find . -name"

# Search specific processes
alias psg="ps -eo pid,user,etime,comm | grep"
# Kill them
alias k9="kill -9"  # SIGKILL

