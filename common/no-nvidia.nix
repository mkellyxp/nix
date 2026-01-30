{ config, pkgs, ... }:

{
  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidia"
    "nvidia_drm"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidiafb"
  ];

  boot.kernelParams = [
    "modprobe.blacklist=nouveau,nvidia,nvidia_drm,nvidia_modeset,nvidia_uvm,nvidiafb"
  ];

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{power/control}="auto"
  '';

  systemd.services.nvidia-runtimepm = {
    description = "Enable runtime PM for NVIDIA dGPU and wait for suspend";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      set -eux

      DEV0=/sys/bus/pci/devices/0000:01:00.0
      DEV1=/sys/bus/pci/devices/0000:01:00.1

      # If the devices aren’t present for some reason, don’t fail boot
      [ -e "$DEV0/power/control" ] && echo auto > "$DEV0/power/control" || true
      [ -e "$DEV1/power/control" ] && echo auto > "$DEV1/power/control" || true

      # Encourage immediate autosuspend (0 ms delay if supported)
      [ -e "$DEV0/power/autosuspend_delay_ms" ] && echo 0 > "$DEV0/power/autosuspend_delay_ms" || true
      [ -e "$DEV1/power/autosuspend_delay_ms" ] && echo 0 > "$DEV1/power/autosuspend_delay_ms" || true

      # Wait up to ~10 seconds for runtime suspend to kick in
      for i in $(seq 1 20); do
        s0=$(cat "$DEV0/power/runtime_status" 2>/dev/null || echo '?')
        s1=$(cat "$DEV1/power/runtime_status" 2>/dev/null || echo '?')
        echo "try $i: $s0 / $s1"
        [ "$s0" = "suspended" ] && [ "$s1" = "suspended" ] && exit 0
        sleep 0.5
      done

      # Don’t fail boot if it never suspends
      exit 0
    '';
  };

  systemd.services.nvidia-runtimepm-resume = {
    description = "Re-enable NVIDIA runtime PM after resume";
    wantedBy = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
    ];
    after = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
    ];
    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      set -eux
      for dev in /sys/bus/pci/devices/0000:01:00.*; do
        [ -e "$dev/power/control" ] && echo auto > "$dev/power/control" || true
        [ -e "$dev/power/autosuspend_delay_ms" ] && echo 0 > "$dev/power/autosuspend_delay_ms" || true
      done
    '';
  };
}
