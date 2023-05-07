{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
  	    firefox
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
    ];
}