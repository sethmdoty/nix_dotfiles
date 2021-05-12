{ pkgs, ... }:

{
  home-manager.users.sethdoty.programs.git = {
    enable = true;
    userName = "Seth Doty";
    userEmail = "sdoty@fpcomplete.com";
    signing.key = "187148A9EE3AD80F";
    signing.signByDefault = true;
    extraConfig = {
      core = { autocrlf = "input"; };
      pull = { rebase = false; };
    };
    ignores =
      [ ".DS_store" ".terraform/*" ".terragrunt-cache" "idea/*" ".direnv/*" ];
  };
}
