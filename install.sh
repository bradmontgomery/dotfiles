#!/bin/bash
echo "Installing dotfiles..."
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Shell files
ln -sf "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/shell/.profile" "$HOME/.profile"
ln -sf "$DOTFILES_DIR/shell/.aliases" "$HOME/.aliases"
ln -sf "$DOTFILES_DIR/shell/.functions" "$HOME/.functions"
ln -sf "$DOTFILES_DIR/shell/.environments" "$HOME/.environments"
echo "- Linked shell files."

# Git files
ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
echo "- Linked git files."

# Vim files
ln -sf "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"
ln -sf "$DOTFILES_DIR/vim/.gvimrc" "$HOME/.gvimrc"
ln -sf "$DOTFILES_DIR/vim/.vim" "$HOME/.vim"
echo "- Linked vim files."

# Dev files
ln -sf "$DOTFILES_DIR/dev/.pypirc" "$HOME/.pypirc"
ln -sf "$DOTFILES_DIR/dev/.isort.cfg" "$HOME/.isort.cfg"
ln -sf "$DOTFILES_DIR/dev/.node-version" "$HOME/.node-version"
ln -sf "$DOTFILES_DIR/dev/.psqlrc" "$HOME/.psqlrc"
echo "- Linked python & node developer settings files."

# Ruby files
ln -sf "$DOTFILES_DIR/ruby/.irbrc" "$HOME/.irbrc"
ln -sf "$DOTFILES_DIR/ruby/.gemrc" "$HOME/.gemrc"
ln -sf "$DOTFILES_DIR/ruby/.rspec" "$HOME/.rspec"
echo "- Linked ruby developer settings files."

# Misc files
ln -sf "$DOTFILES_DIR/misc/.hgrc" "$HOME/.hgrc"

# Opencode settings.
if [[ -d "${HOME}/.config/opencode" ]]; then
    ln -sf "$DOTFILES_DIR/opencode/opencode.json" "$HOME/.config/opencode/opencode.json"
    echo "- Linked opencode configs"
fi

echo "Dotfiles installed successfully!"
echo
