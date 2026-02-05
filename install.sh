#!/bin/bash
set -e
echo "Installing dotfiles..."
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to safely create symlink with error handling
safe_ln() {
    local src="$1"
    local dst="$2"
    local name="$3"

    if [[ ! -e "$src" ]]; then
        echo "Warning: Source file not found: $src" >&2
        return 1
    fi

    if ! ln -sf "$src" "$dst"; then
        echo "Error: Failed to create symlink for $name" >&2
        return 1
    fi
    return 0
}

# Shell files
echo "- Linking shell files..."
safe_ln "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc" "zshrc" || true
safe_ln "$DOTFILES_DIR/shell/.profile" "$HOME/.profile" "profile" || true
safe_ln "$DOTFILES_DIR/shell/.aliases" "$HOME/.aliases" "aliases" || true
safe_ln "$DOTFILES_DIR/shell/.functions" "$HOME/.functions" "functions" || true
safe_ln "$DOTFILES_DIR/shell/.functions.macos" "$HOME/.functions.macos" "functions.macos" || true
safe_ln "$DOTFILES_DIR/shell/.functions.wsl" "$HOME/.functions.wsl" "functions.wsl" || true
safe_ln "$DOTFILES_DIR/shell/.environments" "$HOME/.environments" "environments" || true

# Git files
echo "- Linking git files..."
safe_ln "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig" "gitconfig" || true
safe_ln "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global" "gitignore_global" || true

# Git files
echo "- Linking git files..."
safe_ln "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig" "gitconfig" || true
safe_ln "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global" "gitignore_global" || true

# Vim files
echo "- Linking vim files..."
safe_ln "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc" "vimrc" || true
safe_ln "$DOTFILES_DIR/vim/.gvimrc" "$HOME/.gvimrc" "gvimrc" || true
safe_ln "$DOTFILES_DIR/vim/.vim" "$HOME/.vim" "vim" || true

# Dev files
echo "- Linking python & node developer settings files..."
safe_ln "$DOTFILES_DIR/dev/.pypirc" "$HOME/.pypirc" "pypirc" || true
safe_ln "$DOTFILES_DIR/dev/.isort.cfg" "$HOME/.isort.cfg" "isort.cfg" || true
safe_ln "$DOTFILES_DIR/dev/.node-version" "$HOME/.node-version" "node-version" || true
safe_ln "$DOTFILES_DIR/dev/.psqlrc" "$HOME/.psqlrc" "psqlrc" || true

# Ruby files
echo "- Linking ruby developer settings files..."
safe_ln "$DOTFILES_DIR/ruby/.irbrc" "$HOME/.irbrc" "irbrc" || true
safe_ln "$DOTFILES_DIR/ruby/.gemrc" "$HOME/.gemrc" "gemrc" || true
safe_ln "$DOTFILES_DIR/ruby/.rspec" "$HOME/.rspec" "rspec" || true

# Misc files
echo "- Linking misc files..."
safe_ln "$DOTFILES_DIR/misc/.hgrc" "$HOME/.hgrc" "hgrc" || true

# Opencode settings.
if [[ -d "${HOME}/.config/opencode" ]]; then
    echo "- Linking opencode configs..."
    safe_ln "$DOTFILES_DIR/opencode/opencode.json" "$HOME/.config/opencode/opencode.json" "opencode.json" || true
fi

# Docker Desktop MCP Toolkit symlink for WSL
if grep -qi microsoft /proc/version 2>/dev/null; then
    echo "- Detected WSL environment..."
    DOCKER_BACKEND_SOCK="/mnt/wsl/docker-desktop/shared-sockets/host-services/backend.sock"
    if [[ -S "$DOCKER_BACKEND_SOCK" ]]; then
        mkdir -p "$HOME/.docker/desktop"
        if ln -sf "$DOCKER_BACKEND_SOCK" "$HOME/.docker/desktop/backend.sock"; then
            echo "- Linked Docker Desktop backend socket for MCP Toolkit"
        fi
    fi
fi

echo "Dotfiles installed successfully!"
