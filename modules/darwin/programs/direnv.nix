{ pkgs, ... }:

{
  home-manager.users.sethdoty.programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };
}
