# TODO

- Remove unused auto-loaded nvim plugins (e.g. matchit)
- In the installation script, generate dynamically some files (e.g. append source instructions to zshrc), then compare the final result with the current files to decide whether to backup them
- Make the languages supported in a workspace a first-class citizen of nvim (maybe even global) to lift them from current awkward position as submodules in lsp (and, possibly, treesitter)
- Add nvim git command to visualize unchanged file side-by-side with windiff
- Add nvim git command to visualize merge conflicts with windiff
- (maybe) move git lua files as exported git dotfiles
- ssh mode with local nvim buffers: technically, it is possible with sshfs, but running some locally installed commands on remote files takes forever. another way is use ssh port forwarding to run remote commands and fetch their output locally, but this either assumes local and remote paths to be the same or path mapping support, which is not the case for many commands, including some lsp servers.
- write handy snippets (e.g. python)
- Add Clipboard.ahk to windows-scripts
- Only pull repository info for the specific commit
- Extract tmux nest mode as a separate git submodule
- Use .profile as the environment source of truth. It can be resourced by tmux, which will override the `??_ROOT` env variable before doing so. We can avoid to run self-referential updates like PATH twice by having a guardian env variable. We can also have various modules for profile.
