{ config, lib, fetchurl, appimageTools, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
    gcc
	firefox
	vivaldi
	google-chrome
	spotify
	neovim
	micro
	htop
	neofetch
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
    system76-keyboard-configurator
	(pkgs.callPackage ./beekeeper.nix { })
    ];
}

## NOTES ##
#
# Disable firefox annoying alt menu
#	ui.key.menuAccessKeyFocuses = false 