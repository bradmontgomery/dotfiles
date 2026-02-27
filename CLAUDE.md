# dotfiles

Personal dotfiles for zsh on Linux/WSL2 and macOS. Managed via symlinks.

## Installation

```bash
make install   # runs install.sh, creates symlinks in $HOME
make uninstall # removes all symlinks
```

## Structure

```
dotfiles/
├── shell/      # .zshrc, .profile, .aliases, .functions, .environments
├── git/        # .gitconfig, .gitignore_global
├── vim/        # .vimrc, .gvimrc, .vim/
├── dev/        # .pypirc, .isort.cfg, .node-version, .psqlrc
├── ruby/       # .irbrc, .gemrc, .rspec
├── misc/       # .hgrc
├── claude/     # settings.json → ~/.claude/settings.json (global Claude Code settings)
├── .claude/    # settings.local.json (project-level overrides for this repo only)
├── install.sh  # creates symlinks to $HOME
└── Makefile    # install/uninstall targets
```

## Key facts

- Shell: zsh with oh-my-zsh (robbyrussell theme), direnv, NVM/FNM
- Editor: vim (with vim-plug plugins), gvim for GUI
- Languages used: Python, Go, Node.js, Rust, Ruby, .NET
- Platform: primarily WSL2; also macOS and Linux
- `shell/.environments` sources `$DROPBOXPATH/dotfiles/secrets.sh` for secrets — this file is NOT in this repo and cannot be committed

## Design principles

1. **OS independence**: Configs should work across Linux, macOS, and WSL without modification. Use conditional checks for OS-specific behavior.
2. **Logical organization**: Files are grouped by category (shell, git, vim, etc.), not dumped in the root.
3. **Symlink-based installation**: `install.sh` creates symlinks from `$HOME` to files here.
4. **Modular shell config**: Split into separate concerns — `.zshrc` (main), `.aliases`, `.functions`, `.environments`.

## Shell coding conventions

- Use `[[ ]]` for conditionals (zsh/bash compatible)
- Use `$HOME` instead of `~` or hardcoded `/home/brad` in scripts
- Check for command/directory existence before using optional features:
  ```bash
  if [[ -d "${HOME}/.sometool/bin" ]]; then
      export PATH="${HOME}/.sometool/bin:$PATH"
  fi
  if command -v some_tool &>/dev/null; then
      eval "$(some_tool hook zsh)"
  fi
  ```
- Include `USAGE` comments for custom functions
- Typo-correction aliases are welcome (e.g., `gti=git`, `clera=clear`)

## Adding new configurations

1. Place the config file in the appropriate category directory
2. Add a symlink line to `install.sh`
3. Add the symlink path to the `uninstall` target in `Makefile`
4. Use conditional installation if the config is optional or tool-specific

## Common aliases (from shell/.aliases)

- `st` = `git status`
- `br` = `git branch`
- `get` / `gti` = `git` (typo recovery)
- `serve` = `python3 -m http.server`
- `q` = `kiro-cli`

## Key functions (from shell/.functions)

- `encrypt` / `decrypt` — DES3 symmetric encryption via openssl
- `encrypt_pub` / `decrypt_priv` — RSA asymmetric encryption
- `timerequest <url>` — detailed curl timing breakdown
- `dependablast` — delete all remote dependabot branches
- `ado_repos <project>` — list Azure DevOps repos (requires `$ADO_TOKEN`)
- `start <path>` — WSL: open Windows Explorer at path

## Testing changes

```bash
source ~/.zshrc        # reload shell config
```

```vim
:source ~/.vimrc       " reload vim config
```

## Do not commit

- `shell/.environments` references secrets from Dropbox (`$DROPBOXPATH/dotfiles/secrets.sh`)
- GitHub token and PyPI credentials use placeholder values in repo
