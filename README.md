# dotfiles

These are my dotfiles for unix-like environments. Organized by category for better maintainability.

## Structure

```
dotfiles/
├── shell/          # Shell configuration (.zshrc, .profile, .aliases, .functions, .environments)
├── git/            # Git configuration (.gitconfig, .gitignore_global)
├── vim/            # Vim configuration (.vimrc, .gvimrc, .vim/)
├── dev/            # Development tools (.pypirc, .isort.cfg, .node-version, .psqlrc)
├── ruby/           # Ruby configuration (.irbrc, .gemrc, .rspec)
├── misc/           # Other tools (.hgrc)
├── install.sh      # Installation script
└── Makefile        # Make targets for install/uninstall
```

## Installation

Clone this repository and run the installation:

```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
make install
```

Or use the install script directly:

```bash
./install.sh
```

## Uninstallation

To remove all symlinks:

```bash
make uninstall
```

## Dependencies

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) for zsh configuration
- [vim-plug](https://github.com/junegunn/vim-plug) for vim plugin management

## Notes

- Vim plugins are managed by vim-plug and not included in this repository
- The installation creates symlinks from your home directory to these files
- Existing files will be overwritten, so backup important configurations first

