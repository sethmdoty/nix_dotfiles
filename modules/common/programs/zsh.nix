{ pkgs, ... }:

{
  home-manager.users.sethdoty.programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    defaultKeymap = "emacs";
    history.extended = true;
    initExtra = ''
      ${builtins.readFile ./zsh/shell-aliases.zsh}
      eval "$(zoxide init zsh)"
      eval "$(thefuck --alias)"
    '';
    sessionVariables = rec {
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=9";

      EDITOR = "emacsclient -nw";
      VISUAL = "emacsclient -nw";

      GOPATH = "$HOME/go/";
      PATH =
        "/opt/miniconda3/bin:$HOME/.local/bin:$HOME/.emacs.d/bin:$GOPATH/bin:$PATH";
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.6.3";
          sha256 = "1h8h2mz9wpjpymgl2p7pc146c1jgb3dggpvzwm9ln3in336wl95c";
        };
      }
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "2ed55ecf0c927479e4023395a763da01b13f94ab";
          sha256 = "1skkyb0ydy6ky8pxapgrn35j7kfw1xqy9p1gn4apc4z53xl0ib8s";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
          sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
        };
      }
      {
        name = "zsh-autopair";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
      }
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "0.32.0";
          sha256 = "12l9wrx0aysyj62kgp5limglz0nq73w8c415wcshxnxmhyk6sw6d";
        };
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.0.2";
          sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
        };
      }
    ];
  };
}
