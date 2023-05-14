{ config, lib, fetchurl, appimageTools, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
	firefox
	brave
	spotify
	neovim
	htop
	neofetch
	vscodium
	gitkraken
	git
	tdesktop
	filezilla
	beekeeper-studio
    appimage-run
	vlc
	handbrake
	gnome-text-editor
	(pkgs.callPackage ./beekeeper.nix { })
	(pkgs.callPackage ./minecraft-bedrock.nix { })
    ];
}
