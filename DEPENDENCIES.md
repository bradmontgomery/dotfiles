# External Dependencies

This dotfiles repository uses several external tools. While the configuration is designed to gracefully handle missing tools, here's a comprehensive list of what's needed for full functionality.

## Shell Functions

### Encryption/Decryption
- **openssl** - Required for encrypt/decrypt functions
  - Used by: `encrypt()`, `decrypt()`, `encrypt_pub()`, `decrypt_priv()`
  - Install: Usually pre-installed on macOS/Linux. On Ubuntu: `apt-get install openssl`

### Media Tools
- **ffmpeg** - Required for audio/video conversion
  - Used by: `convert_to_mp3()`, `png2gif()`, `jpg2gif()`
  - Install: `brew install ffmpeg` (macOS) or `apt-get install ffmpeg` (Linux)

### Utilities
- **curl** - Required for HTTP timing and API requests
  - Used by: `timerequest()`, `ado_repos()`
  - Install: Usually pre-installed. On Ubuntu: `apt-get install curl`

- **jq** - Required for JSON parsing
  - Used by: `ado_repos()`
  - Install: `brew install jq` (macOS) or `apt-get install jq` (Linux)

- **pygmentize** - Required for code syntax highlighting (macOS only)
  - Used by: `pyg()` (macOS only in `.functions.macos`)
  - Install: `pip install pygments`

- **zip** - Required for creating LÖVE game archives
  - Used by: `loveit()`
  - Install: Usually pre-installed. On Ubuntu: `apt-get install zip`

### Optional Tools with Graceful Degradation
These tools are optional. Functions will fail gracefully with a clear error message if missing.

- **thefuck** - Command line autocorrection
  - Used in: `.environments`
  - Install: `pip install thefuck`
  - Status: Gracefully skipped if not installed

- **direnv** - Directory-specific environment management
  - Used in: `.zshrc`
  - Install: `brew install direnv` or `apt-get install direnv`
  - Status: Gracefully skipped if not installed

## Shell Configuration

### Required
- **zsh** - Modern shell interpreter
  - Install: `brew install zsh` (macOS) or `apt-get install zsh` (Linux)

- **oh-my-zsh** - Zsh framework and plugin manager
  - Install: `curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh`

- **fnm** - Fast Node version manager (replaces NVM)
  - Used by: `.zshrc`
  - Install: `curl -fsSL https://fnm.io/install | bash`
  - Note: NVM has been removed in favor of fnm for better performance

### Optional (but recommended)
- **direnv** - Directory-specific environment variables
  - Install: `brew install direnv`
  - Allows per-project `.envrc` files for environment setup

- **AWS CLI** - For AWS utilities and completions
  - Install: `pip install awscli`
  - Used by: `.zshrc` for AWS CLI completions

- **Terraform** - For infrastructure automation
  - Install: `brew install terraform`
  - Used by: `.zshrc` for terraform completion

## Vim Configuration

### Required
- **vim** or **neovim** - Text editor
  - Install: `brew install vim` or `apt-get install vim`

- **vim-plug** - Vim plugin manager
  - Install: `curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --create-dirs -o ~/.vim/autoload/plug.vim`

### Vim Plugins (auto-installed via vim-plug)
The `.vimrc` uses vim-plug to automatically download and manage these plugins:

- **vim-isort** - Python import sorting integration
  - Status: Auto-installed but requires `isort` Python package

- **Black** - Python code formatter plugin
  - Status: Auto-installed but requires `black` Python package

- **vim-flake8** - Python linting in Vim
  - Status: Auto-installed but requires `flake8` Python package

- **NERDTree** - Directory navigator for Vim
  - Status: Auto-installed, no dependencies

- **NERDCommenter** - Easy code commenting
  - Status: Auto-installed, no dependencies

- **CtrlP** - Fuzzy file finder
  - Status: Auto-installed, no dependencies

- **Airline** - Status line plugin
  - Status: Auto-installed, no dependencies

## Development Tools

### Python
- **pip** or **pipx** - Package management
  - Install: Usually bundled with Python

- **poetry** - Python dependency management
  - Install: `curl -sSL https://install.python-poetry.org | python3 -`
  - Used by: oh-my-zsh poetry plugin

- **black** - Python code formatter
  - Install: `pip install black`
  - Used by: Vim plugin and aliases

- **flake8** - Python linting
  - Install: `pip install flake8`
  - Used by: Vim plugin

- **mypy** - Python type checker
  - Install: `pip install mypy`
  - Used by: `.aliases` (mypy alias)

- **isort** - Python import sorting
  - Install: `pip install isort`
  - Used by: Vim plugin and `.isort.cfg`

### Ruby
- **ruby** - Language runtime
  - Install: `brew install ruby` or use rbenv/RVM

- **bundler** - Gem dependency manager
  - Install: `gem install bundler`

- **rspec** - Testing framework
  - Install: `gem install rspec`

### Version Control
- **git** - Primary VCS (required)
  - Install: Usually pre-installed. `brew install git` to upgrade

- **tig** - Git log viewer (oh-my-zsh plugin)
  - Install: `brew install tig` (macOS) or `apt-get install tig` (Linux)

- **mercurial** - For hg version control (optional)
  - Install: `brew install mercurial`
  - Used by: `.hgrc` configuration

## Platform-Specific Dependencies

### macOS
- **pbcopy** - Clipboard access (built-in)
- **killall**, **pkill** - Process management (built-in)
- **coreaudiod** - Audio system (built-in, needed for `fixAudio`)

### WSL (Windows Subsystem for Linux)
- **wslpath** - WSL path conversion (built-in with WSL)
- **cmd.exe** - Windows command interpreter (built-in with WSL)

## Quick Installation Guide

### Minimal Setup (essentials only)
```bash
# Shell
brew install zsh fnm

# Git
brew install git

# Vim
brew install vim

# One-time setup
curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --create-dirs -o ~/.vim/autoload/plug.vim
```

### Full Development Setup (macOS)
```bash
# Shell & Runtime
brew install zsh fnm
bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Core tools
brew install git vim curl jq ffmpeg
brew install direnv tig

# Node/Python development
fnm install --cwd-version-file-strategy=recursive
brew install python@3.11
pip install --upgrade pip poetry black flake8 mypy isort pygments thefuck

# Ruby development
brew install ruby
gem install bundler rspec

# Vim plugins
curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --create-dirs -o ~/.vim/autoload/plug.vim
```

## Troubleshooting

### Functions fail with "command not found"
This is expected and handled gracefully. The function will print an error message indicating which tool is missing.

### Shell startup is slow
- Check if all tools are actually installed and in your PATH
- Reduce the number of oh-my-zsh plugins (edit the `plugins` array in `.zshrc`)
- Use `time zsh -i -c exit` to profile shell startup

### Vim plugins aren't working
1. Make sure vim-plug is installed: `~/.vim/autoload/plug.vim` should exist
2. In Vim, run `:PlugInstall` to download plugins
3. Install Python development tools: `pip install black flake8 isort`

### ADO_TOKEN errors in `ado_repos`
Ensure `~/Dropbox/dotfiles/secrets.sh` exists and exports `ADO_TOKEN`. See `.environments` for details.

## Notes on Graceful Degradation

This configuration is designed to work on fresh machines without all tools installed. You'll get:
- Functions that require missing tools will fail with clear error messages
- Optional tools (direnv, thefuck) are silently skipped if missing
- The shell will still load fully and be functional
- You can install tools incrementally as needed

This makes it easy to clone the dotfiles on any machine and have a working shell immediately.
