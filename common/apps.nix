{ config, lib, fetchurl, appimageTools, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    libnotify
    firefox
    brave
    neovim
    helix
    nil
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
    showmethekey
    scrcpy
    obs-studio
    zed-editor
    beekeeper-studio
  ];

  nixpkgs.config.allowInsecurePredicate =
    pkg: builtins.elem (lib.getName pkg) [
      "beekeeper-studio"   # matches any version
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
#
# Helix: open file at filename location
# Ctrl + r / %
