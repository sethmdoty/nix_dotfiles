{ pkgs, config, ... }:

{
  home-manager.users.sethdoty.programs.nushell = {
    enable = true;
    package = pkgs.nushell;

    settings = {
      edit_mode = "emacs";
      completion_mode = "circular";
      rm_always_trash = true;
      skip_welcome_message = true;
      prompt = "STARSHIP_SHELL='nu' echo $(starship prompt)";

      startup = [ ];
    };
  };
  home-manager.users.sethdoty.home.file."Library/Application Support/org.nushell.nu/config.toml".text =
    ''
      completion_mode = "circular"
      edit_mode = "emacs"
      prompt = "STARSHIP_SHELL='nu' echo $(starship prompt)"
      rm_always_trash = true
      skip_welcome_message = true
      startup = [ "pwd"]
        '';
}
