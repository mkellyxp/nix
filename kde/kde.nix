{ config, pkgs, ... }:
{
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the Plasma 5 Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    
    environment.systemPackages = with pkgs; [
        papirus-icon-theme
        wl-clipboard
    ];
}
