{ pkgs, ... }:

{
  home-manager.users.sethdoty.programs.kitty = {
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
  #the following works, but may be better as a home.file.<name>.source to not pollute the config
  #https://nix-community.github.io/home-manager/options.html#opt-home.file._name_.source

  home-manager.users.sethdoty.home.file.".config/kitty/nord.conf".text = ''
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
}
