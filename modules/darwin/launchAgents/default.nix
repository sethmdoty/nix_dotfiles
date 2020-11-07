{ pkgs, config, lib, ... }:
lib.mkIf (pkgs.stdenv.isDarwin) {
  home-manager.users.sethdoty = {
    home.file."Library/LaunchAgents/link-ssh-auth-sock.plist".source =
      ./link-ssh-auth-sock.plist;
    home.file."Library/LaunchAgents/homebrew.gpg.gpg-agent.plist".source =
      ./homebrew.gpg.gpg-agent.plist;
  };
}
