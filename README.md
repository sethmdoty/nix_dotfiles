I follow the nixpkgs unstable channel on my darwin machines. I don't like to sudo, so I remove the nixpkgs channel from root, and add it to my user like this: nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs