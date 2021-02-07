{ pkgs, config, lib, ... }: {
  home-manager.users.sethdoty = { home.file.".config/i3/config".source = ../../conf.d/i3.conf ; };
}
