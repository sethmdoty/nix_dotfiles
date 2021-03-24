{ pkgs, ... }:

{
  home-manager.users.sethdoty.programs.emacs = {
    enable = true;
    package = pkgs.emacsMacport;
  };
}
