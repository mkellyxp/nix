{
  config,
  lib,
  fetchurl,
  appimageTools,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    gcc
    libnotify
    firefox
    helix
    nixfmt
    lazygit
    gitkraken
    htop
    fastfetch
    vscode
    git
    appimage-run
    vlc
    stripe-cli
    protonvpn-gui
    obs-studio
    zed-editor
    beekeeper-studio
  ];

  nixpkgs.config.allowInsecurePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "beekeeper-studio" # matches any version
    ];

}

## NOTES ##
#
# Disable firefox annoying alt menu
#	ui.key.menuAccessKeyFocuses = false
#
# Audible convert
#	nix-shell -p audible-cli aaxtomp3 ffmpeg
#	audible quickstart
#	audible activation-bytes
#	aaxtomp3 --authcode 3a560803 DragonPlanet_ep7.aax
#
# Split audio into smaller files
#	ffmpeg -i Zero\ G-1\ Chapter\ 1.mp3 -f segment -segment_time 600 -c copy chap1-%03d.mp3
# ONE LINE FOR YOTO
# i=1; for f in *.mp3; do ffmpeg -i "$f" -f segment -segment_time 600 -c copy "chap${i}-%03d.mp3"; i=$((i+1)); done
#
# Helix: open file at filename location
# Ctrl + r / %
