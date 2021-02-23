{ config, lib, pkgs, ... }:

with pkgs; {
  environment.systemPackages = [ terminal-notifier ];
}
