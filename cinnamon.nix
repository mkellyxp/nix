# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  
  # Fix for trackpad
  #	test: journalctl -xeu restart-trackpad.service
  systemd.services.restart-trackpad= {
    serviceConfig.Type = "oneshot";
    wantedBy = [ "wpa_supplicant.service" ];
    after = [ "wpa_supplicant.service" ];
    path = with pkgs; [ bash ];
    script = ''
      /run/current-system/sw/bin/rmmod i2c_hid_acpi
      /run/current-system/sw/bin/modprobe i2c_hid_acpi
    '';
  };

  powerManagement.resumeCommands = ''
      echo "Restarting Trackpad on Wake";
      /run/current-system/sw/bin/rmmod i2c_hid_acpi
      /run/current-system/sw/bin/modprobe i2c_hid_acpi
  '';


  networking.hostName = "herobook"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "intel" ];



  # Enable the GNOME Desktop Environment.
  ## services.xserver.displayManager.gdm.enable = true;
  ## services.xserver.desktopManager.gnome.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  ## services.xserver.displayManager.sddm.enable = true;
  ## services.xserver.desktopManager.plasma5.enable = true;
  
  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  xdg.portal.enable = true;



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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	# gnomeExtensions.appindicator
	# gnomeExtensions.hide-universal-access
  	# gnome.gnome-tweaks
	# gnome.gnome-software
	gnome.gnome-screenshot
	neovim
	git
	htop
	neofetch
	vscodium
	arc-theme
	papirus-icon-theme
	wmctrl
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.flatpak.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
