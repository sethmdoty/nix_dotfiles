# # darwin-rebuild switch -I darwin-config=$HOME/.nixpkgs/darwin-configuration.nix
{ config, pkgs, ... }:
let
  unstableTarball = fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";

in {
  imports = [ <home-manager/nix-darwin> ./modules/darwin ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = import ./packages.nix { inherit pkgs; };

  system.defaults = {

    dock = { autohide = false; };
    trackpad.Clicking = true;
    trackpad.TrackpadThreeFingerDrag = false;

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
      packageOverrides = pkgs: {
        unstable = import unstableTarball { config = config.nixpkgs.config; };
      };
    };
  };

  fonts = {
    enableFontDir = true;
    fonts = [
      pkgs.material-icons
      pkgs.font-awesome
      pkgs.source-sans-pro
      pkgs.jetbrains-mono
      pkgs.nerdfonts
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
        extraPackages = epkgs: [ epkgs.vterm ];
      };
      git = {
        enable = true;
        userName = "Seth Doty";
        userEmail = "seth.doty@objectpartners.com";
        extraConfig = {
          core = { autocrlf = "input"; };
          pull = { rebase = false; };
        };
        ignores = [ ".DS_store" ".terraform/*" ".terragrunt-cache" "idea/*" ];
      };
      gpg = {
        enable = true;
        settings = {
          auto-key-retrieve = true;
          no-emit-version = true;
          cert-digest-algo = "SHA256";
          no-comments = false;
          personal-cipher-preferences = "AES AES256 AES192 CAST5";
          personal-digest-preferences = "SHA256 SHA512 SHA384 SHA224";
          ignore-time-conflict = true;
          allow-freeform-uid = true;
          default-key = "15305FB3273A136CE971B47F187148A9EE3AD80F";
          use-agent = true;
        };
      };

      kitty = {
        enable = true;
        font.package = pkgs.nerdfonts;
        font.name = "MesloLGL Nerd Font";
        settings = { enable_audio_bell = false; };
      };
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
