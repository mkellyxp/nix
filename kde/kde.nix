{ config, pkgs, ... }:
{
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the Plasma 5 Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    virtualisation.libvirtd.enable = true;
    boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
    
    environment.systemPackages = with pkgs; [
        wl-clipboard
        gnome.gnome-boxes
    ];
}
