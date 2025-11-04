{ config, pkgs, ... }:
{
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the Mate Desktop Environment.
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.mate.enable = true;
    xdg.portal.enable = true;

    environment.systemPackages = with pkgs; [
        arc-theme
        fuzzel
        rofi
        mate.mate-tweak
    ];
}
