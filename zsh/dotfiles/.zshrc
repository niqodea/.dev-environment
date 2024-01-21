function() {

    # ROOT
    # We can inject zsh with a root
    # Ideally, zsh should always operate inside the root
    if [ -z "$ZSH_ROOT" ]; then
        export ZSH_ROOT="$HOME"
    fi

    alias cdr='cd "$ZSH_ROOT"'


    # WORKSPACE CONFIG
    # We can create a workspace config directory inside a working directory
    # Programs can use the workspace config to store state and contextualize their operation,
    # allowing them to tailor their behavior based on the originating working directory
    # NOTE: WORKSPACE_CONFIG_DIR is a first-class citizen in our dotfiles, many configs rely on it
    alias mkw='mkdir "$WORKSPACE_CONFIG_DIR"'


    # SHELL VARIABLE
    # The zsh we use might be /bin/zsh or, if we manage to compile it, $HOME/.local/bin/zsh
    # Changing SHELL to refer to a locally installed one using chsh is risky, so we dynamically
    # update it to refer to the currently running zsh instead
    # Ref: https://www.cyberciti.biz/tips/how-do-i-find-out-what-shell-im-using.html
    export SHELL="$(readlink "/proc/$$/exe")"


    # PROMPT SETUP
    setopt PROMPT_SUBST

    function setup_prompt_base() {
        export PROMPT_BASE="$1"

        local COLOR_OFF='%f'
        local SHELL_STATE='%#'
        export PROMPT="${PROMPT_BASE}${COLOR_OFF}${SHELL_STATE} "
    }

    if [ -z "$PROMPT_BASE" ]; then
        local COLOR_USERHOST='%F{099}'  # Purple
        local COLOR_CWD='%F{220}'  # Yellow

        local USER='%n'
        local HOST='%m'
        local CWD='%~'

        setup_prompt_base "${COLOR_USERHOST}${USER}@${HOST}${COLOR_CWD}[${CWD}]"
    fi


    # HISTORY
    HISTFILE="$ZSH_ROOT/.zsh_history"
    HISTSIZE=100000  # Num commands stored in the file
    SAVEHIST=100000  # Num commands loaded into memory from history file
    setopt HIST_IGNORE_ALL_DUPS  # Don't store duplicate commands
    setopt INC_APPEND_HISTORY  # Append to history file immediately


    # DIRECTORY STACK
    # Ref: https://thevaluable.dev/zsh-install-configure-mouseless/
    setopt AUTO_PUSHD
    setopt PUSHD_IGNORE_DUPS
    setopt PUSHD_SILENT


    # COMPLETION
    # Ref: https://thevaluable.dev/zsh-completion-guide-examples/
    # Ref: https://github.com/Phantas0s/.dotfiles/blob/4c41b4865528714dbdeb18c8da42b4d1ca5a2182/zsh/completion.zsh
    autoload -Uz compinit; compinit -C  # Use cache to reduce startup time by ~0.1s
    # Have another thread refresh the cache in the background (subshell to hide output)
    (autoload -Uz compinit; compinit &)

    zstyle ':completion:*' menu 'select'
    unsetopt LIST_BEEP  # Disable beep on tab completion
    # Beep on exit (with ^C) can technically be disabled by wrapping the widget for
    # autocomplete to set NO_BEEP when run, but it's not worth the effort, too brittle

    zstyle ':completion:*' group-name ''  # Use group names as separators
    zstyle ':completion:*:*:*:*:descriptions' format '%F{cyan}-- %d --%f'
    zstyle ':completion:*:*:*:*:warnings' format '%F{red}no matches found%f'

    # Vim-like keybindings for menu navigation
    zmodload -i zsh/complist
    bindkey -M menuselect '^h' 'vi-backward-char'
    bindkey -M menuselect '^k' 'vi-up-line-or-history'
    bindkey -M menuselect '^j' 'vi-down-line-or-history'
    bindkey -M menuselect '^l' 'vi-forward-char'
    bindkey -M menuselect '^d' 'vi-forward-word'
    bindkey -M menuselect '^u' 'vi-backward-word'

    # Enable autocompletion for . and ..
    # Ref: https://stackoverflow.com/a/716926
    zstyle ':completion:*' special-dirs 'true'


    # MISCELLAENOUS

    # Enable vi mode
    # Ref: https://stackoverflow.com/a/58188295
    bindkey -v
    # Fix backspace only deleting inserted characters in insert mode
    # Ref: https://unix.stackexchange.com/a/290403
    bindkey -v '^?' backward-delete-char


    # EXTENSIONS
    # Source local zsh config, if it exists
    local local_zsh_path="$HOME/.local.zsh"
    if [[ -f "$local_zsh_path"  ]]; then
        source "$local_zsh_path"
    fi

    # Source modules
    local zsh_modules_env_path="$ZSH_ROOT/.zsh-modules-env.zsh"
    if [ -f "$zsh_modules_env_path" ]; then
        source "$zsh_modules_env_path"
    fi
    source "$HOME/.zsh-modules/main.zsh"

}

# NOTES
# We use anonymous function to scope variables and avoid flooding the env
# Ref: https://stackoverflow.com/a/13670749
# It is generally recommended to always run autoload with -Uz flags
# Ref: https://unix.stackexchange.com/a/214306
