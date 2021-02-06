{ pkgs, ... }:

{
  home-manager.users.sethdoty.programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
