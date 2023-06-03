{ config, lib, fetchurl, appimageTools, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
	firefox
	google-chrome
	spotify
	neovim
	htop
	neofetch
	vscodium
	gitkraken
	git
    jq
	tdesktop
	filezilla
	beekeeper-studio
    appimage-run
	vlc
	handbrake
	gnome-text-editor
    zoom-us
    elixir
	inotify-tools
    system76-keyboard-configurator
	(pkgs.callPackage ./beekeeper.nix { })
	(pkgs.callPackage ./minecraft-bedrock.nix { })
    ];
}
