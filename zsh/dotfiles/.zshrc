# SESSION ROOT
# We can inject zsh with a session root
# Programs run from the shell can use this information to contextualize their operation, allowing
# them to tailor their behavior based on the originating workspace
if [ -n "${ZSH_SESSION_ROOT+x}" ]; then
    alias cds='cd $ZSH_SESSION_ROOT'
fi


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
local_zshrc_path=~/.local.zshrc
if [[ -f $local_zshrc_path  ]]; then
	source $local_zshrc_path
fi

# CORE MODULES
for core_module_path in ~/.zsh/core/*.zshrc; do
    source $core_module_path
done

# OPTIONAL MODULES
function () {
    if [ -n "${ZSH_OPTIONAL_MODULES+x}" ]; then
        for optional_module in ${(z)ZSH_OPTIONAL_MODULES}; do
            source ~/.zsh/opt/$optional_module.zshrc
        done
    fi
}

function sm() {  # source-module
    local optional_module=$1
    local optional_module_path=~/.zsh/opt/$optional_module.zshrc

    if [ ! -e $optional_module_path ]; then
        >&2 echo "zsh module not found at $optional_module_path"
        return 1
    fi

    if [[ " $ZSH_OPTIONAL_MODULES " == *" $optional_module "* ]]; then
        >&2 echo "zsh module $optional_module already sourced"
        return 1
    fi

    if [ -z "${ZSH_OPTIONAL_MODULES+x}" ]; then
        export ZSH_OPTIONAL_MODULES="$optional_module"
    else
        export ZSH_OPTIONAL_MODULES="$ZSH_OPTIONAL_MODULES $optional_module"
    fi

    source $optional_module_path
}


# NOTES
# We use anonymous function to scope variables and avoid flooding the env
# Ref: https://stackoverflow.com/a/13670749
# It is generally recommended to always run autoload with -Uz flags
# Ref: https://unix.stackexchange.com/a/214306

