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
