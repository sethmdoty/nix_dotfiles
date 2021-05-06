{ config, pkgs, ... }:

with pkgs;
let unstable = import <nixos-unstable> { };

in {
  environment.systemPackages = [
    firefox
    element-desktop
    slack
    thefuck
    kitty
    nitrokey-app
    emacs
    clipmenu
    pavucontrol
    syncthing-tray
    zathura
    discord
    conda
  ];
}
