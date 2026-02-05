.PHONY: install uninstall

install:
	@echo "Installing dotfiles..."
	@./install.sh

uninstall:
	@echo "Removing dotfiles symlinks..."
	@rm -f ~/.zshrc ~/.profile ~/.aliases ~/.functions ~/.environments
	@rm -f ~/.gitconfig ~/.gitignore_global
	@rm -f ~/.vimrc ~/.gvimrc ~/.vim
	@rm -f ~/.pypirc ~/.isort.cfg ~/.node-version ~/.psqlrc
	@rm -f ~/.irbrc ~/.gemrc ~/.rspec
	@rm -f ~/.hgrc
	@rm -f ~/.docker/desktop/backend.sock
	@echo "Dotfiles uninstalled!"
