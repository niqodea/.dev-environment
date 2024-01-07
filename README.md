# Dev Environment

Monorepo containing dotfiles and programs for my development environment.

## Module Structure

Each directory at the root of the repository is a module with the following standardized structure:

- `install-bin.sh`: a script to install programs on the machine
- `dotfiles/`: the dotfiles to install
- `exported-dotfiles/`: dotfiles installed by other modules
- `bin-submodules/`: git submodules containing programs to install
- `dotfiles-submodules/`: git submodules containing dotfiles to install
- `README.md`: information about the module

### Dotfiles management

Each file in the `dotfiles` directory is of the form:

```
.path%2Fto%2Fdotfile
```

When installed, the path is first resolved by replacing instances of `%2F` as `/`.
Then, they are copied in the user's home directory, possibly replacing existing ones.
In the case of directories, dotfiles are replaced entirely and not merged.

Dotfiles with a `.sample` suffix are intended to be customized for local machine configurations.
This involves renaming them by removing the suffix and editing their contents to suit the settings of the specific machine.

### Rationale for exporting dotfiles

Sometimes, a module's configuration includes elements that are closely related to the functionality of another module.
For instance, `zsh`'s aliases may be more logically connected to the programs they alias, belonging to a different module.

To maintain a cohesive structure, we create these dotfiles within the module offering these functionalities.
Then, we create symbolic links to these files in the dotfiles directory of the module that imports them.

### Git submodules

We use git submodules to make our repository smaller and easier to manage, especially when working with external projects.

Submodules in `bin-submodules` help us build the programs.
This is useful because it lets us tailor the setup, install programs without needing special permissions, use the newest versions, and ensure consistent performance by locking the repository to a specific commit.

Submodules in `dotfiles-submodules` include files we link to in the dotfiles directory.
This helps us know which files we handle and which come from outside sources.

### Breadcrumbs

Our project uses symlinks extensively to make sure each file has only one main version.
To move up in the directory structure, we use a method called [Breadcrumbs](https://github.com/niqodea/breadcrumbs).
It is better than using lots of `../` in symlinks, which can be hard to read and might break unexpectedly.
Breadcrumbs are special symlinks named `.*.bc` and are used all over our project.

## Installation

To install programs, run this from the root of the repository:

```sh
./install-bin.sh [module1] [module2] [...]
```

You can also specify the installation path with `-p` (default is `~/.local`).

To install dotfiles, run:

```sh
./install-dotfiles.sh [module1] [module2] [...]
```

The script will move existing, conflicting dotfiles in a backup directory.

Note: both scripts install all the modules if no module is specified.
