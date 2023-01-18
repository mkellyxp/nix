# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  networking.extraHosts = ''
    127.0.0.1	www.course.local
    127.0.0.1 	www.admin.local
  '';


  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
<<<<<<< HEAD
  ##services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
=======
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  environment.gnome.excludePackages = (with pkgs; [
    gnome.geary
    gnome.gnome-boxes
  ]);
>>>>>>> main

  
  # Enable the Plasma 5 Desktop Environment.
  ## services.xserver.displayManager.sddm.enable = true;
  ## services.xserver.desktopManager.plasma5.enable = true;
  
  # Enable the Cinnamon Desktop Environment.
  ## services.xserver.displayManager.lightdm.enable = true;
  ## services.xserver.desktopManager.cinnamon.enable = true;
  ## xdg.portal.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mkelly = {
    isNormalUser = true;
    description = "Mike Kelly";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # For Gnome
    gnomeExtensions.appindicator
    gnomeExtensions.just-perfection
<<<<<<< HEAD
=======
    gnomeExtensions.sound-output-device-chooser
>>>>>>> main
    gnome.gnome-tweaks
    
    # For Cinnamon
    ## gnome.gnome-screenshot

    # For Sway
    ## light
    ## foot
    ## dmenu
    ## grim
    ## slurp
    ## xfce.thunar
    ## gnome-icon-theme
    ## brightnessctl
    ## gnome.gnome-tweaks

    
    # General Packages
    papirus-icon-theme
    arc-theme
    firefox
    neovim
    gthumb
    vscodium
    nodejs
    docker
    docker-compose
    php
    php81Packages.composer
    git
    htop
    libarchive
<<<<<<< HEAD
    appimage-run
    wapiti
=======
    wget
    wmctrl
    android-tools
>>>>>>> main
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  virtualisation.docker.enable = true;
<<<<<<< HEAD
  virtualisation.virtualbox.host.enable = true;
  services.flatpak.enable = true;
  services.fwupd.enable = true;

  users.extraGroups.vboxusers.members = [ "mkelly" ];
=======
  services.flatpak.enable = true;

>>>>>>> main


  ## MYSQL STUFF
  ## services.mysql = {
  ##   enable = true;
  ##   package = pkgs.mysql;
  ## };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
  
  ## NOTES
  # gsettings set org.gnome.desktop.privacy remember-recent-files false

  # To connect to online accounts
  # WEBKIT_FORCE_SANDBOX=0 gnome-control-center online-accounts

}