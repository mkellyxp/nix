{ config, lib, fetchurl, appimageTools, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
		gcc
		firefox
		librewolf
		google-chrome
		neovim
		helix
		nil
		yazi
		htop
		neofetch
		vscodium
		git
		appimage-run
		vlc
		stripe-cli
		dbeaver
		protonvpn-gui
	    nerdfonts
	    showmethekey
	    sublime4
		(pkgs.callPackage ./beekeeper.nix { })
    ];

    nixpkgs.config.permittedInsecurePackages = [
        "openssl-1.1.1w"
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
#
# Sublime Text
#	Control + Shift + p - Package Control
#		- Install LSP
#		- Install LSP Php
#		- Install LSP tailwindcss
#		- Install LSP elixir
#   - Install HTML Syntax in Script
#		- LSP Settings ( "lsp_format_on_save": true )
#		- Key Bindings ( { "keys": ["ctrl+shift+s"], "command": "reveal_in_side_bar" } )
#		- LSP Tailwind Settings ( "disabled_capabilities": { "colorProvider": true, }, )
#		- Preference Settings ( "word_wrap": false, )
