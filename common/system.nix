{ config, pkgs, ... }:
let
  ## Notify Users Script
  notifyUsersScript = pkgs.writeScript "notify-users.sh" ''
    set -eu

    title="$1"
    body="$2"

    users=$(${pkgs.systemd}/bin/loginctl list-sessions --no-legend | ${pkgs.gawk}/bin/awk '{print $1}' | while read session; do
      loginctl show-session "$session" -p Name | cut -d'=' -f2
    done | sort -u)

    for user in $users; do
      ${pkgs.sudo}/bin/sudo -u "$user" \
        DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u "$user")/bus" \
        ${pkgs.libnotify}/bin/notify-send "$title" "$body"
    done
  '';

in
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

      (writeShellScriptBin "nix-rebuild" ''
        sudo nixos-rebuild --flake /home/mkelly/Projects/nix --impure "$@"
      '')
    ];
   
    systemd.timers."auto-update-config" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "auto-update-config.service";
      };
    };

    systemd.services.auto-update-config = {
      path = with pkgs; [
        git
        nix
        gnugrep
        gawk
        util-linux  # for `ionice`, `runuser`
        coreutils-full  # for `nice`, `id`, etc.
        flatpak
        libnotify
        sudo
        systemd  # for `loginctl`
      ];

      script = ''
        set -eu

        git_output=$(runuser -u mkelly -- ${pkgs.git}/bin/git -C /home/mkelly/Projects/nix pull --autostash 2>&1)

        flatpak_output=$(nice -n 19 ionice -c 3 flatpak update --noninteractive --assumeyes 2>&1)

        if echo "$flatpak_output" | grep -q "Nothing to do."; then
          echo "Flatpak update: Nothing to do. No notification sent."
        else
          ${notifyUsersScript}  "Apps Updated" "$flatpak_output"
        fi
      '';

      serviceConfig = {
        Type = "oneshot";
        User = "root";
        Restart = "on-failure";
        RestartSec = "30s";
      };

      after = [ "network-online.target" "graphical.target" ];
      wants = [ "network-online.target" ];
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
