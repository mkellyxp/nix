{ config, pkgs, ... }:

{
    ## boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.kernel.sysctl = { "vm.swappiness" = 10;};

    services.fwupd.enable = true;
    services.flatpak.enable = true;

    #zramSwap.enable = true;

    # Enable sound with pipewire.
    # sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };
}

## To check generations
# sudo nix-env -p /nix/var/nix/profiles/system --list-generations


## Optional Things ##
#
# boot.supportedFilesystems = [ "ntfs" ];
# virtualisation.docker.enable = true;
# services.flatpak.enable = true;

## For Laptops ##
# services.power-profiles-daemon.enable = false;
# services.tlp = {
#   enable = true;
#   settings = {
#       CPU_SCALING_GOVERNOR_ON_AC = "performance";
#       CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
#
#       CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
#       CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
#
#       CPU_MIN_PERF_ON_AC = 0;
#       CPU_MAX_PERF_ON_AC = 100;
#       CPU_MIN_PERF_ON_BAT = 0;
#       CPU_MAX_PERF_ON_BAT = 50;
#
#       START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
#       STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
#   };
# };
