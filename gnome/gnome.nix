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
        gnome-themes-extra
        gnome-tweaks
        gnome-boxes
        gnome-terminal
        gthumb
        papirus-icon-theme
        wmctrl
        wl-clipboard
    ];
    
    nixpkgs.overlays = [
        (final: prev: {
          gitkraken = prev.gitkraken.overrideAttrs (oldAttrs: rec {
            desktopItems = [
              (prev.makeDesktopItem {
                name = "GitKraken";
                exec = "gitkraken --enable-features=UseOzonePlatform --ozone-platform=wayland";
                icon = "gitkraken";
                desktopName = "GitKraken Desktop";
                genericName = "Git Client";
                categories = [ "Development" ];
                comment = "Unleash your repo";
              })
            ];
          });
        })
    ];
}

## NOTES
#
# gsettings set org.gnome.desktop.privacy remember-recent-files false
