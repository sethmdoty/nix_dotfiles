{ config, pkgs, lib, ... }:

with pkgs;

{
  imports = [ ../common/programs ./packages.nix ../common/flake8Config ];
}
