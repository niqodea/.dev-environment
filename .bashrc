function setup_prompt() {
	unset -f $FUNCNAME  # No need to access this function after sourcing

	# These placeholders are formatted natively by bash
	# Ref: https://ss64.com/bash/syntax-prompt.html
	local USER="\u"
	local HOST="\h"
	local CWD="\w"
	local ROOT_FLAG="\\\$"  # \$

	# These are commands invoked dynamically for each prompt thanks to single quotes

	# Print current git branch, if any
	# Ref: https://stackoverflow.com/questions/15883416
	local GIT_BRANCH='$(__git_ps1 " (%s)")'

	# Colors
	# Ref: https://gist.github.com/vratiu/9780109
	# Note: Bash changes text color every time it parses a new code
	local NO_COLOR="\[\033[00m\]"
	local GREEN="\[\033[0;92m\]"
	local BLUE="\[\033[0;94m\]"
	local YELLOW="\[\033[0;33m\]"

	# Build prompt by setting environment variable
	# PS1 is the primary prompt string, we can ignore others
	# Ref: https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html
	PS1=$BLUE$USER"@"$HOST$NO_COLOR":"$YELLOW$CWD$GREEN$GIT_BRANCH$NO_COLOR$ROOT_FLAG" "
}
setup_prompt

