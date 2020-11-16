{ pkgs, ... }:

{
  home-manager.users.sethdoty.programs.git = {
    enable = true;
    userName = "Seth Doty";
    userEmail = "seth.doty@objectpartners.com";
    extraConfig = {
      core = { autocrlf = "input"; };
      pull = { rebase = false; };
    };
    ignores = [ ".DS_store" ".terraform/*" ".terragrunt-cache" "idea/*" ];
  };
}
