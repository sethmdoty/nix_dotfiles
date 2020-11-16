{ pkgs, ... }:

{
  home-manager.users.sethdoty.programs.emacs = {
    enable = true;
    package = pkgs.emacsMacport;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}
