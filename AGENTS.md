# AGENTS.md

This is a personal dotfiles repository for Unix-like environments. It contains shell (primarily zsh), git, vim, and development tool configurations used across multiple operating systems including Linux, macOS, and Windows (WSL).

## Project Structure

```
dotfiles/
├── shell/      # Shell configuration (.zshrc, .profile, .aliases, .functions, .environments)
├── git/        # Git configuration (.gitconfig, .gitignore_global)
├── vim/        # Vim configuration (.vimrc, .gvimrc, .vim/)
├── dev/        # Development tools (.pypirc, .isort.cfg, .node-version, .psqlrc)
├── ruby/       # Ruby configuration (.irbrc, .gemrc, .rspec)
├── misc/       # Other tools (.hgrc)
├── opencode/   # OpenCode AI assistant configuration
├── install.sh  # Installation script (creates symlinks to $HOME)
└── Makefile    # Make targets for install/uninstall
```

## Design Principles

1. **OS Independence**: Configurations should work across Linux, macOS, and Windows (WSL) without modification. Use conditional checks when OS-specific behavior is necessary.

2. **Logical Organization**: Files are grouped by category (shell, git, vim, etc.) rather than dumped in the root directory.

3. **Symlink-Based Installation**: The install script creates symlinks from `$HOME` to files in this repository, allowing centralized management.

4. **Modular Shell Configuration**: Shell config is split into separate concerns:
   - `.zshrc` - Main zsh configuration and oh-my-zsh setup
   - `.profile` - Login shell profile
   - `.aliases` - Command shortcuts
   - `.functions` - Custom shell functions
   - `.environments` - Environment variables and PATH modifications

## Coding Conventions

### Shell Files

- Use `[[ ]]` for conditionals (zsh/bash compatible)
- Check for command/directory existence before using OS-specific features:
  ```bash
  if [[ -d "${HOME}/.config/opencode" ]]; then
      # opencode-specific config
  fi

  if command -v some_tool; then
      # tool-specific config
  fi
  ```
- Use `$HOME` instead of `~` in scripts for consistency
- Include USAGE comments for custom functions
- Source external files conditionally: `[ -f ~/.ssh_hosts ] && . ~/.ssh_hosts`

### Aliases

- Typo corrections are welcome (e.g., `gti=git`, `clera=clear`)
- Keep aliases short and mnemonic
- Group related aliases together with comments

### Environment Variables

- Check for existence of directories/tools before setting related paths
- Use conditional blocks for OS-specific or optional tool configurations

## Adding New Configurations

1. Place the config file in the appropriate category directory
2. Update `install.sh` to create the symlink
3. Update the `uninstall` target in `Makefile` to remove the symlink
4. Use conditional installation if the config is optional or tool-specific

## Dependencies

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) - Required for zsh configuration
- [vim-plug](https://github.com/junegunn/vim-plug) - Required for vim plugin management
- [direnv](https://direnv.net/) - Used for directory-specific environment variables

## Testing Changes

After modifying shell configurations, source them to test:
```bash
source ~/.zshrc
```

For vim changes, restart vim or source the vimrc:
```vim
:source ~/.vimrc
```
