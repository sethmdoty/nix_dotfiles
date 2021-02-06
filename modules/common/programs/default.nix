{ config, pkgs, lib, ... }:

with pkgs;

{
  imports = [
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./kitty.nix
    ./nushell.nix
    ./starship.nix
    ./zsh.nix
  ];
}
