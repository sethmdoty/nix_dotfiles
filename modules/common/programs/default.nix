{ config, pkgs, lib, ... }:

with pkgs;

{
  imports = [
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./gnupg.nix
    ./kitty.nix
    #./nushell.nix
    ./starship.nix
    ./zsh.nix
  ];
}
