{ config, pkgs, ... }:

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
    ];
}