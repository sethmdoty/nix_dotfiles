# # darwin-rebuild switch -I darwin-config=$HOME/.nixpkgs/darwin-configuration.nix
{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ./modules/darwin ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = import ./packages.nix { inherit pkgs; };

  system.defaults = {

    dock = { autohide = false; };
    trackpad.Clicking = true;
    trackpad.TrackpadThreeFingerDrag = true;

  };

  system = {
    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToControl = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowUnsupportedSystem = false;
    };
  };

  fonts = {
    enableFontDir = true;
    fonts = [
      pkgs.material-icons
      pkgs.font-awesome
      pkgs.source-sans-pro
      pkgs.jetbrains-mono
    ];
  };
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.nixpkgs/darwin-configuration.nix";
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  #
  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;
  # Enable various package settings
  #
  services = {
    lorri = { enable = true; };

  };
  users.users.sethdoty.shell = pkgs.zsh;
  home-manager.users.sethdoty = {

    home.sessionVariables = {
      PAGER = "less -R";
      EDITOR = "emacsclient";
    };

    programs = {
      home-manager = { enable = true; };

      direnv = { enable = true; };

      emacs = {
        enable = true;
        package = pkgs.emacsMacport;
      };
      git = {
        enable = true;
        userName = "Seth Doty";
        userEmail = "seth.doty@objectpartners.com";
      };
      zsh = { enable = true; };
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
