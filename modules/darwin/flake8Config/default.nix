{ pkgs, config, lib, ... }:
lib.mkIf (pkgs.stdenv.isDarwin) {
  home-manager.users.sethdoty = { home.file.".flake8".source = ./flake8; };
}
