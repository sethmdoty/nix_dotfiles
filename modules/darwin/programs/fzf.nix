{ pkgs, ... }:

{
  home-manager.users.sethdoty.programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
