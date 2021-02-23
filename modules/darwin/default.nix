{ config, pkgs, lib, ... }:

with pkgs;

{
  imports = [
    ./globalEmacsKeyBindings
    ./programs/emacs.nix
    ./programs/firefox.nix
    ./launchAgents/default.nix
    ../common/programs
    ../common/flake8Config
    ./programs.nix
  ];
}
