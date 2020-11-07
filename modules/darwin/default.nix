{ config, pkgs, lib, ... }:

with pkgs;

{
  imports =
    [ ./globalEmacsKeyBindings ./flake8Config ./gnupg.nix ./launchAgents ];
}
