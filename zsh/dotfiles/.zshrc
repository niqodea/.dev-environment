# SHELL VARIABLE
# The zsh we use might be /bin/zsh or, if we manage to compile it, $HOME/.local/bin/zsh
# Changing SHELL to refer to a locally installed one using chsh is risky, so we dynamically update
# it to refer to the currently running zsh instead
# Ref: https://www.cyberciti.biz/tips/how-do-i-find-out-what-shell-im-using.html
export SHELL=$(readlink /proc/$$/exe)

# SESSION ROOT
# We can inject zsh with a session root
# Programs run from the shell can use this information to contextualize their operation, allowing
# them to tailor their behavior based on the originating workspace
if [ -z "$ZSH_SESSION_ROOT" ]; then
    export ZSH_SESSION_ROOT=$HOME
fi

alias cds='cd $ZSH_SESSION_ROOT'

function () {
    local zsh_session_env_path=$ZSH_SESSION_ROOT/.session-env.zshrc 
    if [ -f $zsh_session_env_path ]; then
        source $zsh_session_env_path
    fi
}


# PROMPT SETUP
setopt PROMPT_SUBST

function setup_prompt_base() {
    export PROMPT_BASE=$1

	local COLOR_OFF="%f"
	local SHELL_STATE="%#"
    export PROMPT="${PROMPT_BASE}${COLOR_OFF}${SHELL_STATE} "
}

function () {
    if [ -n "${PROMPT_BASE+x}" ]; then
        return
    fi

	local COLOR_USERHOST="%F{099}"  # Purple
	local COLOR_CWD="%F{220}"  # Yellow

	local USER="%n"
	local HOST="%m"
	local CWD="%~"

	setup_prompt_base "${COLOR_USERHOST}${USER}@${HOST}${COLOR_CWD}[${CWD}]"
}



# HISTORY
# Ref: https://www.soberkoder.com/better-zsh-history/
HISTFILE=~/.zsh_history
HISTSIZE=100000  # Num commands stored in the file
SAVEHIST=100000  # Num commands loaded into memory from history file
# Ref: https://zsh.sourceforge.io/Doc/Release/Options.html#History
setopt histignorealldups
setopt sharehistory


# COMPLETION
# Ref: https://zsh.sourceforge.io/Doc/Release/Completion-System.html
autoload -Uz compinit
compinit

# List possible autocompletions and highlight selected one
zstyle ':completion:*' menu select

# Use shift-TAB to go back to previous autocompletion
# Ref: https://unix.stackexchange.com/a/84869
zmodload -i zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete
# Enable autocompletion for . and ..
# Ref: https://stackoverflow.com/a/716926
zstyle ':completion:*' special-dirs true
# Enable lower-to-upper case matching
# Ref: https://stackoverflow.com/a/68794830
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'
# Enable group names
# Ref: https://stackoverflow.com/a/40869479
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format '%F{cyan}-- %d --%f'

# MISCELLAENOUS

# Enable vi mode
# Ref: https://stackoverflow.com/a/58188295
bindkey -v
# Fix backspace only deleting inserted characters in insert mode
# Ref: https://unix.stackexchange.com/a/290403
bindkey -v '^?' backward-delete-char

# Source local zshrc, if it exists
function () {
    local local_zshrc_path=~/.local.zshrc
    if [[ -f $local_zshrc_path  ]]; then
        source $local_zshrc_path
    fi
}

# MODULES
for core_module_path in ~/.zsh-modules/core/*.zshrc; do
    source $core_module_path
done

if [ -n "$ZSH_SESSION_MODULES" ]; then
    for session_module in ${(z)ZSH_SESSION_MODULES}; do
        source ~/.zsh-modules/extra/$session_module.zshrc
    done
fi

if [ -n "$ZSH_EXTRA_MODULES" ]; then
    for extra_module in ${(z)ZSH_EXTRA_MODULES}; do
        source ~/.zsh-modules/extra/$extra_module.zshrc
    done
fi

function sm() {
    # Source a new optional module by name
    local extra_module=$1
    local extra_module_path=~/.zsh-modules/extra/$extra_module.zshrc

    if [ ! -e $extra_module_path ]; then
        >&2 echo "zsh module not found at $extra_module_path"
        return 1
    fi

    if [[ " $ZSH_EXTRA_MODULES " == *" $extra_module "* ]]; then
        return  # extra_module already sourced
    fi

    export ZSH_EXTRA_MODULES="${ZSH_EXTRA_MODULE+$ZSH_EXTRA_MODULES }$extra_module"

    source $extra_module_path
}


# NOTES
# We use anonymous function to scope variables and avoid flooding the env
# Ref: https://stackoverflow.com/a/13670749
# It is generally recommended to always run autoload with -Uz flags
# Ref: https://unix.stackexchange.com/a/214306

