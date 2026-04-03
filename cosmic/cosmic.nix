{ config, pkgs, ... }:
{
  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the Cosmic Desktop Environment.
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  # services.desktopManager.cosmic.xwayland.enable = true;

  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [
    "kvm-amd"
    "kvm-intel"
  ];

  environment.systemPackages = with pkgs; [
    gthumb
    # wl-clipboard
  ];
}

## NOTES
#
# gsettings set org.gnome.desktop.privacy remember-recent-files false
