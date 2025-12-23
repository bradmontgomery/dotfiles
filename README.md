# dotfiles

These are my dotfiles for unix-like environments. Organized by category for better maintainability.

## Project Structure

This repository is organized into logical categories to make configuration management easier:

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

### Directory Details

- **shell/**: ZSH configuration with oh-my-zsh setup, custom aliases, functions, and environment variables
- **git/**: Git global configuration and ignore patterns
- **vim/**: Complete Vim setup with custom configuration and plugin directory structure
- **dev/**: Development tool configurations for Python, Node.js, PostgreSQL, and code formatting
- **ruby/**: Ruby development environment settings including IRB, Gem, and RSpec configurations
- **misc/**: Additional version control and miscellaneous tool configurations

## Installation

### Quick Setup

Clone this repository and run the installation:

```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
make install
```

### Manual Installation

Or use the install script directly:

```bash
./install.sh
```

The installation process creates symlinks from your home directory to the configuration files in this repository. This allows you to manage all your dotfiles from a single location while keeping them in their expected locations.

### Uninstallation

To remove all symlinks:

```bash
make uninstall
```

## Vim Setup

### Prerequisites

Install vim-plug for plugin management:

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Plugin Installation

After running the dotfiles installation, open Vim and install plugins:

```vim
:PlugInstall
```

### Key Features

- **Plugin Management**: Uses vim-plug for easy plugin installation and updates
- **Code Formatting**: Integrated Black formatter for Python code
- **File Navigation**: NERDTree for file browsing, CtrlP for fuzzy file finding
- **Syntax Highlighting**: Enhanced syntax support for multiple languages
- **Code Quality**: Flake8 integration for Python linting
- **Commenting**: NERDCommenter for easy code commenting
- **Airline**: Status line with Git integration and themes

### Plugin Updates

To update all plugins:

```vim
:PlugUpdate
```

To clean unused plugins:

```vim
:PlugClean
```

## Dependencies

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) for zsh configuration
- [vim-plug](https://github.com/junegunn/vim-plug) for vim plugin management

## Notes

- Vim plugins are managed by vim-plug and not included in this repository
- The installation creates symlinks from your home directory to these files
- Existing files will be backed up automatically during installation
- All configurations are designed to work across different Unix-like systems

