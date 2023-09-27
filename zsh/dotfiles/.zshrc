# SESSION ROOT
# We can inject zsh with a session root
# Programs run from the shell can use this information to contextualize their operation, allowing
# them to tailor their behavior based on the originating workspace
if [ -z "${ZSH_SESSION_ROOT+x}" ]; then
    export ZSH_SESSION_ROOT=$HOME
fi
alias cds='cd $ZSH_SESSION_ROOT'


# PROMPT SETUP
# Ref: https://gist.github.com/reinvanoyen/05bcfe95ca9cb5041a4eafd29309ff29
function () {

	# These placeholders are formatted natively by zsh
	# Ref: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Shell-state
	local USER="%n"
	local HOST="%m"
	local CWD="%~"
	local SHELL_STATE="%#"

	# If in a git repo, return the active branch within parentheses ()
	# We want to run this dynamically each time the prompt is printed, so we use
	# single quotes not to run the command just yet
	local GIT_BRANCH='$(git branch 2> /dev/null | sed -n -e "s/^\* \(.*\)/(\1)/p")'

	# Colors
	local COLOR_OFF="%f"
	local COLOR_USERHOST="%F{099}"  # Purple
	local COLOR_CWD="%F{220}"  # Yellow

	export PROMPT_BASE="${COLOR_USERHOST}${USER}@${HOST}${COLOR_CWD}[${CWD}]"
	export PROMPT="${PROMPT_BASE}${COLOR_OFF}${SHELL_STATE} "
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
zsh_sourced_optional_modules=()
function so() {  # source-optional
    local optional_module=$1
    if [[ " $zsh_sourced_optional_modules " == *" $optional_module "* ]]; then
        return
    fi
    local optional_module_path=~/.zsh/opt/$optional_module.zshrc
    source $optional_module_path
    zsh_sourced_optional_modules+=($optional_module)
}

function () {
    if [ -n "${ZSH_STARTING_OPTIONAL_MODULES+x}" ]; then
        local optional_modules_array
        read -rA optional_modules_array <<< "$ZSH_STARTING_OPTIONAL_MODULES"

        local optional_module
        for optional_module in "${optional_modules_array[@]}"; do
            so $optional_module
        done
    fi
}

# NOTES
# We use anonymous function to scope variables and avoid flooding the env
# Ref: https://stackoverflow.com/a/13670749
# It is generally recommended to always run autoload with -Uz flags
# Ref: https://unix.stackexchange.com/a/214306

