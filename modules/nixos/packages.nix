{ config, pkgs, ... }:

with pkgs;
let unstable = import <nixos-unstable> { };

in {
  environment.systemPackages = [
    unstable.nyxt
    firefox
    element-desktop
    slack
    kitty
    nitrokey-app
    ((emacsPackagesNgGen emacs).emacsWithPackages (epkgs: [ epkgs.vterm ]))
    clipmenu
    pavucontrol
    syncthing-tray
    zathura
    discord
  ];
}
