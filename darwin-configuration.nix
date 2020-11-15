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
    #the following works, but may be better as a home.file.<name>.source to not pollute the config
    #https://nix-community.github.io/home-manager/options.html#opt-home.file._name_.source
    home.file.".config/kitty/nord.conf".text = ''
            #: Color scheme
      foreground   #D8DEE9
      background   #2E3440

      # black
      color0       #3B4252
      color8       #4C566A

      # red
      color1       #BF616A
      color9       #BF616A

      # green
      color2       #A3BE8C
      color10      #A3BE8C

      # yellow
      color3       #EBCB8B
      color11      #EBCB8B

      # blue
      color4       #81A1C1
      color12      #81A1C1

      # magenta
      color5       #B48EAD
      color13      #B48EAD

      # cyan
      color6       #88C0D0
      color14      #8FBCBB

      # white
      color7       #E5E9F0
      color15      #ECEFF4

      # Url
      url_color #D08770

      # Border
      active_border_color #88C0D0

      # Tabs
      active_tab_foreground   #ECEFF4
      active_tab_background   #4C566A
      inactive_tab_foreground #8FBCBB
      inactive_tab_background #4C566A
          '';
    programs = {
      home-manager = { enable = true; };

      direnv = {
        enable = true;
        enableNixDirenvIntegration = true;
      };

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
        settings = {
          enable_audio_bell = false;
          sync_to_monitor = false;
          copy_on_select = true;
          cursor_shape = "block";
          mouse_hide_wait = "3.0";
          url_style = "curly";
          open_url_modifiers = "kitty_mod";
          strip_trailing_spaces = "smart";
          terminal_select_modifiers = "shift";
          draw_minimal_borders = true;
          window_padding_width = "10.0";
          placement_strategy = "center";
          tab_bar_edge = "bottom";
          tab_bar_margin_width = "0.0";
          tab_bar_style = "powerline";
          background_opacity = "0.9";
          kitty_mod = "alt";
          clear_all_shortcuts = false;
          include = "nord.conf";
        };
        keybindings = {
          "ctrl+shift+c" = "copy_to_clipboard";
          "ctrl+shift+v" = "paste_from_clipboard";
          "kitty_mod+u" = "kitten hints";
          "ktty_mod+enter" = "new_window";
          "kitty_mod+r" = "start_resizing_window";
          "kitty_mod+]" = "next_window";
          "kitty_mod+[" = "previous_window";
          "ktty_mod+k" = "move_window_to_top";
          "kitty_mod+t" = "new_tab";
          "ktty_mod+w" = "close_tab";
          "ktty_mod+i" = "set_tab_title";
          "kitty_mod+l" = "nex_tab";
          "kitty_mod+h" = "previous_tab";
          "kitty_mod+shift+L" = "move_tab_forward";
          "kitty_mod+shift+H" = "move_tab_backward";
          "kitty_mod+1" = "goto_tab 1";
          "kitty_mod+2" = "goto_tab 2";
          "kitty_mod+3" = "goto_tab 3";
          "kitty_mod+4" = "goto_tab 4";
          "kitty_mod+5" = "goto_tab 5";
          "kitty_mod+shift+E" = "edit_config_file";
          "kitty_mod+shift+U" = "kitten unicode_input";
        };
      };
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
