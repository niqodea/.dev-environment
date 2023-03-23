source ~/.aliases

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
	local COLOR_GIT="%F{034}"  # Green

	setopt PROMPT_SUBST
	export PROMPT="${COLOR_USERHOST}${USER}@${HOST}${COLOR_CWD}[${CWD}]${COLOR_GIT}${GIT_BRANCH}${COLOR_OFF}${SHELL_STATE} "
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

# Source local zsh config file, if it exists
if [[ -f "$HOME/.zshrc.local"  ]]; then
	source "$HOME/.zshrc.local" 
fi

# EXTERNAL SUBMODULES

# Set up fuzzy finder
# Note: Must be done after setting keymap to vi
# Ref: https://unix.stackexchange.com/a/651460
if [ -f ~/.zshrc.fzf ]; then
	source ~/.zshrc.fzf
else
	echo "WARNING: File $HOME/.zshrc.fzf not found, did you run the install script on this machine?"
fi

# NOTES
# We use anonymous function to scope variables and avoid flooding the env
# Ref: https://stackoverflow.com/a/13670749
# It is generally recommended to always run autoload with -Uz flags
# Ref: https://unix.stackexchange.com/a/214306

