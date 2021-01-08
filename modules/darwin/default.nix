{ config, pkgs, lib, ... }:

with pkgs;

{
  imports = [
    ./globalEmacsKeyBindings
    ./flake8Config
    ./gnupg.nix
    ./programs/nushell.nix
    ./programs/starship.nix
    ./programs/fzf.nix
    ./programs/gpg.nix
    ./programs/emacs.nix
    ./programs/git.nix
    ./programs/direnv.nix
    ./programs/zsh.nix
    ./programs/kitty.nix
    ./programs/firefox.nix
    ./launchAgents/default.nix
  ];
}
