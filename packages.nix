{ pkgs }:

with pkgs; [
  (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
  exa
  fd
  fzf
  pinentry_mac
  tmux
  lorri
  ansible-lint
  dive
  shellcheck
  terminal-notifier
  go
  hadolint
  jq
  thefuck
  yamllint
  nixfmt
  bat
  zsh-completions
  zsh-syntax-highlighting
  multimarkdown
  black
  cmake
  python38Packages.flake8
  python38Packages.cfn-lint
  python38Packages.pylint
  pipenv
  packer
  pre-commit
  unstable.terraform_0_13
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
  python38
  sqlite
  google-cloud-sdk
  ripgrep
  wget
  zsh
]
