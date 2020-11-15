.PHONY: all
all: dotfiles lsp ## Installs the bin files and the dotfiles.

.PHONY: dotfiles
dotfiles: ## Installs the dotfiles.
 ## add aliases for dotfiles
	stow emacs
	ln -s Library/Mobile\ Documents/com\~apple\~CloudDocs/org ~/org

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

