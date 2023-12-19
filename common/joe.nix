{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        git
	    google-chrome
        firefox
        neovim
    ];

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    };

    services.flatpak.enable = true;

}