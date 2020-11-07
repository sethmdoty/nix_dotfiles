.PHONY: all
all: dotfiles lsp ## Installs the bin files and the dotfiles.

.PHONY: dotfiles
dotfiles: ## Installs the dotfiles.
 ## add aliases for dotfiles
	gpg --list-keys || true;
	stow emacs
	stow zsh
	ln -s Library/Mobile\ Documents/com\~apple\~CloudDocs/org ~/org

.PHONY: lsp
lsp: ##Install various lsp products
	npm install -g dockerfile-language-server-nodejs
	npm install -g yaml-language-server
	npm install -g stylelint
	npm install -g js-beautify
	sudo gem install solargraph
	wget https://github.com/juliosueiras/terraform-lsp/releases/download/v0.0.11-beta2/terraform-lsp_0.0.11-beta2_darwin_amd64.tar.gz -P ~/Downloads/

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

