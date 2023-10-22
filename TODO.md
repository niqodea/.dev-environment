# TODO

- Remove unused auto-loaded nvim plugins (e.g. matchit)
- In the installation script, generate dynamically some files (e.g. append source instructions to zshrc), then compare the final result with the current files to decide whether to backup them
- Make the languages supported in a workspace a first-class citizen of nvim (maybe even global) to lift them from current awkward position as submodules in lsp (and, possibly, treesitter)
- Change autopilot to only trigger manually (auto-activation causing lags for things like scrolling the autocompletion options)
- Refactor modules to have bin-submodules mirroring dotfiles-submodules
- Implement mypy makeprg in a generic way to account for other linters in the future

