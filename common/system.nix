{ config, pkgs, ... }:

{
    # boot.kernelPackages = pkgs.linuxPackages_latest;
    # boot.kernelPackages = pkgs.linuxPackages_zen;

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

    services.printing.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };


    environment.systemPackages = with pkgs; [
      git
      libnotify
      gawk
      gnugrep
      sudo
      flatpak
      openssh
    ];


    systemd.services."auto-update-config" = {
    script = ''
      set -eu
      export GIT_SSH=${pkgs.openssh}/bin/ssh
      export PATH=${pkgs.git}/bin:${pkgs.openssh}/bin:${pkgs.coreutils-full}/bin:${pkgs.util-linux}/bin:${pkgs.flatpak}/bin:$PATH

      # Update nixbook configs
      runuser -u mkelly -- ${pkgs.git}/bin/git -C /home/mkelly/Projects/nix pull

      # Flatpak Updates
      ${pkgs.coreutils-full}/bin/nice -n 19 ${pkgs.util-linux}/bin/ionice -c 3 ${pkgs.flatpak}/bin/flatpak update --noninteractive --assumeyes
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    wantedBy = [ "multi-user.target" ]; # Ensure the service starts after rebuild
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
