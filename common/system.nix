{ config, pkgs, ... }:

    {
    ## boot.kernelPackages = pkgs.linuxPackages_latest;

    services.fwupd.enable = true; 

    zramSwap.enable = true;

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };


    ## Automatic Updates ##

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };



    ## Optional Things ##
    #
    # boot.supportedFilesystems = [ "ntfs" ];
    # virtualisation.docker.enable = true;
    # services.flatpak.enable = true;
}