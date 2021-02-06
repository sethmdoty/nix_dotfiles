This repo manages all my Mac machines and my nixos machine in one repository.  I want things to be very consistent across my environments so I try to create a lot of common configuration across environments by default.

Common components are under modules/common. Typically I will default to common functionality to maintain the common components across machines, and heavily use nix-shells where I can.

The configuration.nix file is for NixOS and the darwin-configuration.nix file is for mac. 
To get started, just sync this repo to  to /etc/nixos on NixOS or .nixpkgs if you are on your mac. If on a mac, the configuration will automatically set the appropriate variables to find the config file in these locations. 

I follow the nixpkgs unstable channel on my darwin machines. I don't like to sudo on my darwin machines, so I remove the nixpkgs channel from root, and add it to my user like this: 
`nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs`

Finally, I have some ongoing work to use the lib folder to set variables since I have a lot of repetition with my user. Work will continue with that migration.
