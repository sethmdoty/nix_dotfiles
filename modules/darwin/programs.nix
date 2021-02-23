{ config, lib, pkgs, ... }:

with pkgs; {
  environment.systemPackages = [ pinentry_mac terminal-notifier ];
}
