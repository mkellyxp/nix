{ config, lib, fetchurl, appimageTools, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
    gcc
	firefox
	google-chrome
	brave
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
    appimage-run
	vlc
	handbrake
	gnome-text-editor
    zoom-us
    elixir
	gimp
	inkscape
	inotify-tools
	android-tools
	stripe-cli
    system76-keyboard-configurator
	(pkgs.callPackage ./beekeeper.nix { })
	(pkgs.callPackage ./minecraft-bedrock.nix { })
    ];
}
