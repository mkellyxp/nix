{ config, lib, fetchurl, appimageTools, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
		gcc
		firefox
		google-chrome
		neovim
		htop
		neofetch
		vscode
		git
		appimage-run
		vlc
		stripe-cli
		dbeaver
		protonvpn-gui
		(pkgs.callPackage ./beekeeper.nix { })
		(pkgs.callPackage ./minecraft-bedrock.nix { })
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
