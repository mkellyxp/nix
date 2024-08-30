{ config, pkgs, ... }:
{
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    virtualisation.libvirtd.enable = true;
    boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

    environment.systemPackages = with pkgs; [
        gnomeExtensions.hide-universal-access
        gnomeExtensions.steal-my-focus-window
        gnomeExtensions.appindicator
        gnome.gnome-themes-extra
        gnome.gnome-tweaks
        gnome.gnome-boxes
        papirus-icon-theme
        wmctrl
        wl-clipboard
    ];
}

## NOTES
#
# gsettings set org.gnome.desktop.privacy remember-recent-files false
