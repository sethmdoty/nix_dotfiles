{ pkgs, config, lib, ... }:
lib.mkIf (pkgs.stdenv.isDarwin) {
  environment.userLaunchAgents = {
    syncthing = {
      source = ./local.syncthing.plist;
      target = "org.nixos.syncthing.plist";
    };
  };
}
