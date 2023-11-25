# TODO

- Remove unused auto-loaded nvim plugins (e.g. matchit)
- In the installation script, generate dynamically some files (e.g. append source instructions to zshrc), then compare the final result with the current files to decide whether to backup them
- Make the languages supported in a workspace a first-class citizen of nvim (maybe even global) to lift them from current awkward position as submodules in lsp (and, possibly, treesitter)
- Add nvim git command to visualize unchanged file side-by-side with windiff
- Add nvim git command to visualize merge conflicts with windiff
- (maybe) move git lua files as exported git dotfiles
- ssh mode with local nvim buffers: technically, it is possible with sshfs, but running some locally installed commands on remote files takes forever. another way is use ssh port forwarding to run remote commands and fetch their output locally, but this either assumes local and remote paths to be the same or path mapping support, which is not the case for many commands, including some lsp servers.
- write handy snippets (e.g. python)
- Differentiate git alias (core) and prompt (extra) zsh modules
- Make e.g. pass.zsh also sourceable by sh to leverage pass-short-show in tmux actions. This will probably require `ZSH_ROOT` to be renamed `SH_ROOT`. Probably best to have a conditional setup of the variable (if unset) in .profile.
- Add Clipboard.ahk to windows-scripts
- Explore whether setting a different default command can make the process of setting `ZSH_ROOT` cleaner (probably not ideal to break commands like split sh or split zsh though)
- Only pull repository info for the specific commit
