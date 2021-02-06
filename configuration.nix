# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let unstable = import <nixos-unstable> { };
in {
  imports = [ # Include the results of the hardware scan.
    ./hosts/yoga/hardware-configuration.nix
    <home-manager/nixos>
    ./modules/nixos
    ./modules/common/packages.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enableCryptodisk = true;
  boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_latest;
  boot.blacklistedKernelModules = [ "snd_hda_intel" "snd_soc_skl" ];
  boot.tmpOnTmpfs = true;
  # Set your time zone.
  time.timeZone = "America/Chicago";
  #allow ufree packages
  nixpkgs.config.allowUnfree = true;
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  networking = {
    hostName = "yoga";
    networkmanager.enable = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  fonts.fonts = with pkgs; [ source-sans-pro jetbrains-mono ];
  # Enable the Plasma 5 Desktop Environment.
  services.xserver.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;
  services.autorandr.enable = true;
  services.xserver.modules = [ pkgs.xf86_input_wacom ];
  services.xserver.wacom.enable = true;
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "dvorak";
    xkbOptions = "ctrl:swapcaps";
    libinput = {
      enable = true;
      tapping = true;
      accelProfile = "adaptive";
      accelSpeed = "0.6";
      clickMethod = "clickfinger";
      disableWhileTyping = true;
    };
    displayManager = {
      defaultSession = "none+i3";
      #   lightdm = enable;
    };
    displayManager.autoLogin = {
      enable = true;
      user = "sethdoty";
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
        xss-lock
        (polybar.override {
          pulseSupport = true;
          nlSupport = true;
          i3Support = true;
        })
        rofi
        dunst
        redshift
        scrot
        nitrogen
      ];
    };
    #desktopManager.plasma5.enable = true;
    desktopManager.xterm.enable = false;
    # Enable CUPS to print documents.
    # services.printing.enable = true;
  };
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.extraConfig = ''
    load-module module-alsa-sink defivce=hw:0,0 channels=4
    load-module module-alsa-source device=hw:0,6 channels=4
  '';
  # Enable touchpad support (enabled default in most desktopManager).
  #services.xserver.libinput.enable = true;
  services.lorri.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sethdoty = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
    ]; # Enable ‘sudo’ for the user.
  };
  home-manager.users.sethdoty = {
    home.sessionVariables = { EDITOR = "emacsclient"; };
    programs = { home-manager = { enable = true; }; };
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  services.udev.packages = [ pkgs.nitrokey-udev-rules ];
  programs.ssh.startAgent = false;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

