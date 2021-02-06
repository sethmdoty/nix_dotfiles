{ pkgs, config, lib, ... }: {
  home-manager.users.sethdoty = { home.file.".flake8".source = ./flake8; };
}
