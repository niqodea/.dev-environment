# Listing files
alias l='ls --color'  # Add colors to ls
alias la='l -a'
alias ll='l -hl'  # -h is for human-readable file size
alias lal='l -ahl'

# Easier navigation in directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Size of files
alias duh='du -hs'

# Find
alias f='find .'
alias fn='find . -name'

# Search specific processes
alias psg='ps -eo pid,user,etime,comm | grep'
# Kill them
alias k9='kill -9'  # SIGKILL

# Load updated global history
alias fcr='fc -R'

# Print current working directory
alias p='pwd'
alias pp='pwd -P'

function bkp () {
    local file_path="$1"
    if [ -z "$file_path" ]; then
        >&2 echo "No path provided"
        return 1
    fi
    if [ ! -e "$file_path" ]; then
        >&2 echo "Path does not exist: $file_path"
        return 1
    fi

    local backup_file_path="$file_path.bkp"
    if [ -e "$backup_file_path" ]; then
        bkp "$backup_file_path"
    fi

    mv -- "$file_path" "$backup_file_path"
}

function sshw () {
    local workstation="$1"

    local ssh_command="ssh -t"  # -t to specify a command to run at the end
    # Options for sturdier connections
    ssh_command="$ssh_command -o ServerAliveInterval=60 -o ServerAliveCountMax=3"

    for port in {50000..50019}; do
        ssh_command="$ssh_command -L 0.0.0.0\:$port\:localhost\:$port"
    done

    ssh_command="$ssh_command $workstation"
    # Connect to tmux, launching the server if necessary
    ssh_command="$ssh_command 'tmux ls &> /dev/null && tmux attach || tmux new'"

    sh -c "$ssh_command"
}
