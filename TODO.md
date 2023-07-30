# TODO

- Provide an easy way to update PATH variable that is idempotent w.r.t. tmux (https://unix.stackexchange.com/q/366553)
- Install all programs inside the user's home directory
- Remove unused auto-loaded nvim plugins (e.g. matchit)
- In the installation script, generate dynamically some files (e.g. append source instructions to zshrc), then compare the final result with the current files to decide whether to backup them
- As of now, focus events are a bit overkill, as we would like not to use them for nothing else than neovim autosave. However, they cause other problems such as being sent to the shell if previously requested by a nested TMUX session that was abruptly terminated via SSH escape sequence. We technically never have a purpose for TMUX to receive focus events. Ideally, we would like to have a focus-events mode that generates them when switching pane, but does not request them to the application above when turned on. Disabling the focus reporting of the inner tmux manually does not seem feasible, because the escape sequence '\e[?1004l' sent by the inner tmux is consumed by the inner tmux itself and there is no way to disable this behavior. One possible solution to this would be to create a command that creates a special tmux pane running a neovim instance that listens to focus in/out events, and to define tmux hooks that sends focus in/out events only to specific types of panes.
- Explore nvim directory tree plugins like nerdtree

