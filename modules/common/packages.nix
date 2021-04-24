{ config, pkgs, ... }:

with pkgs; {
  environment.systemPackages = [
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    unzip
    git
    exa
    fd
    fzf
    zoxide
    multitail
    tmux
    syncthing
    dive
    proselint

    shellcheck
    go
    hadolint
    jq
    thefuck
    yamllint
    dhall
    dhall-json
    dhall-lsp-server
    nixfmt
    bat
    multimarkdown
    black
    cmake
    python38Packages.pyflakes
    python38Packages.isort
    python38Packages.pytest
    python38Packages.markdown
    python38Packages.nose
    poetry
    graphviz
    pipenv
    packer
    pre-commit
    stow
    tflint
    tree
    awscli2
    nodejs
    terraform-docs
    gawk
    azure-cli
    automake
    autoconf
    poppler
    gnupg
    python39
    sqlite
    google-cloud-sdk
    gnumake
    ripgrep
    wget
    zsh
    zsh-completions
    zsh-syntax-highlighting
    direnv
    nix-direnv
    killall
    coursier
    ##Doom Requirements
    terraform
    gocode
    gomodifytags
    gotests
    gore
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.bash-language-server
    terraform-lsp
    nodePackages.coc-stylelint
    nodePackages.js-beautify
    solargraph
  ];
}
