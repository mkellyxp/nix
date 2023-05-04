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
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "swayin"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.extraHosts = ''
    127.0.0.1 www.course.local
    127.0.0.1 www.admin.local
    127.0.0.1	www.public.local
    127.0.0.1	www.dad.local
  '';

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    #media-session.enable = true;
  };


  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mkelly = {
    isNormalUser = true;
    description = "Mike Kelly";
    extraGroups = [ "networkmanager" "wheel" "video" "nginx" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.dbus.enable = true;
  programs.light.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	firefox
	spotify
	neovim
	htop
	neofetch
	vscodium
	gitkraken
	fuzzel
	foot
	kitty
	slurp
	grim
	xfce.thunar
	xfce.tumbler
	ffmpegthumbnailer
	git
	tdesktop
	arc-theme
	xorg.xlsclients
	xdg-utils
	glib
	bc
	swaylock
	swayidle
	wl-clipboard
	libnotify
	mako
	filezilla
	gthumb
	beekeeper-studio
	php80
	nodejs
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.mysql = {
  	enable = true;
  	package = pkgs.mariadb;
  };

  services.nginx = {
  	enable = true;
	virtualHosts."www.admin.local" = {
		root = "/var/www/vip_member_vault_admin";
		locations."= /" = {
              		extraConfig = ''
                		rewrite ^ /index.php;
              		'';
          	};
		locations."/".extraConfig = ''
			try_files $uri $uri/ /index.php?$query_string;
		'';
		locations."~ \.php$".extraConfig = ''
			fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
			fastcgi_index index.php;
		'';

	};
	virtualHosts."www.course.local" = {
		root = "/var/www/vip_member_vault";
		locations."= /" = {
              		extraConfig = ''
                		rewrite ^ /index.php;
              		'';
          	};
		locations."/".extraConfig = ''
			try_files $uri $uri/ /index.php?$query_string;
		'';
		locations."~ \.php$".extraConfig = ''
			fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
			fastcgi_index index.php;
		'';

	};
	virtualHosts."www.public.local" = {
		root = "/var/www/public_site_2023";
		locations."= /" = {
              		extraConfig = ''
                		rewrite ^ /index.php;
              		'';
          	};
		locations."/".extraConfig = ''
			try_files $uri $uri/ /$uri.php;
		'';
		locations."~ \.php$".extraConfig = ''
			fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
			fastcgi_index index.php;
		'';

	};


  };

  services.phpfpm = {
  	pools.mypool = {
		phpPackage = pkgs.php80;
  		user = "nobody";
		settings = {
			pm = "dynamic";
			"listen.owner" = config.services.nginx.user;
			"pm.max_children" = 5;
			"pm.start_servers" = 2;
			"pm.min_spare_servers" = 1;
			"pm.max_spare_servers" = 3;
			"pm.max_requests" = 500;
		};
  	};
};


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  ## NOTES ##
  #
  # To launch chromium apps in wayland, add:
  # 	--enable-features=UseOzonePlatform --ozone-platform=wayland
  #
  #	Can copy .desktop files from: /run/current-system/sw/share/applications/
  #	to: ~/.local/share/applications
  #
  # To set mysql password
  #	sudo mysql -uroot
  # 	ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyN3wP4ssw0rd';
  #	flush privileges;
  #	exit;


}
