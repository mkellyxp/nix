{ config, lib, fetchurl, appimageTools, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
    gcc
	firefox
	google-chrome
	spotify
	neovim
	micro
	htop
	neofetch
	slack
    vscode
	gitkraken
	git
    jq
	tdesktop
	filezilla
	libreoffice
    appimage-run
	vlc
	siglo
	handbrake
	gnome-text-editor
    zoom-us
    elixir
	gimp
	blackbox-terminal
	inkscape
	inotify-tools
	android-tools
	heimdall
	stripe-cli
	dbeaver
	burpsuite
	flashrom
    system76-keyboard-configurator
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
