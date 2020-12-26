# # darwin-rebuild switch -I darwin-config=$HOME/.nixpkgs/darwin-configuration.nix
{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ./modules/darwin ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = import ./packages.nix { inherit pkgs; };
  home-manager.useUserPackages = true;

  system.defaults = {

    dock = { autohide = false; };
    trackpad.Clicking = true;
    trackpad.TrackpadThreeFingerDrag = false;
  };

  system = {
    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToControl = true;
  };

  nixpkgs.overlays = [ (import ./overlays) ];
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowUnsupportedSystem = false;
      # packageOverrides = pkgs: {
      #   unstable = import unstableTarball { config = config.nixpkgs.config; };
      # };
    };
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
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
  ###########
  services.skhd.enable = true;
  services.skhd.skhdConfig = builtins.readFile ./conf.d/skhd.conf;

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = {
      window_border = "off";
      window_border_width = 4;
      active_window_border_color = "0xff81a1c1";
      normal_window_border_color = "0xff3b4252";
      focus_follows_mouse = "off";
      mouse_follows_focus = "on";
      window_placement = "second_child";
      window_opacity = "off";
      window_topmost = "on";
      window_shadow = "float";
      active_window_opacity = "1.0";
      normal_window_opacity = "1.0";
      split_ratio = "0.50";
      auto_balance = "on";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      layout = "bsp";
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 5;
    };

    extraConfig = ''
      # rules
      yabai -m rule --add app='System Preferences' manage=off
      yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
      yabai -m rule --add label="App Store" app="^App Store$" manage=off
      yabai -m rule --add label="Calculator" app="^Calculator$" manage=off
      yabai -m rule --add label="VirtualBox" app="^VirtualBox$" manage=off
    '';
  };

  ########
  users.users.sethdoty.shell = pkgs.zsh;
  home-manager.users.sethdoty = {
    home.sessionVariables = { EDITOR = "emacsclient"; };
    programs = { home-manager = { enable = true; }; };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
