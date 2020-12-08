.PHONY: all
all: dotfiles ## Installs the bin files and the dotfiles.

.PHONY: dotfiles
dotfiles: ## Installs the dotfiles.
 ## add aliases for dotfiles
	stow emacs
 ## ln -s Library/Mobile\ Documents/com\~apple\~CloudDocs/org ~/org

install-nixpkgs:
	sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon;

install-home-manager:
	nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install

init: install-nixpkgs install-home-manager

collect-garbage:
	@echo "\nCollecting Garbage..."
	@nix-collect-garbage -d

upgrade:
	@echo "\nUpgrading Nix..."
	@nix upgrade-nix

	@echo "\nUpdating Nix Channels..."
	@nix-channel --update

	@echo "\nUpgrading Nix Environment..."
	@nix-env --upgrade

	@echo "\nActivating new Home Manager Generation..."
	@home-manager switch

switch:
ifdef profile
	@echo -e "\nAttempting to link Home Manager Profile $(profile)..."
	@ln -fs ./profiles/$(profile).nix ./home.nix
endif
	@echo -e "\nActivating Home Manager Profile..."
	@home-manager switch

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

