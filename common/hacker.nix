{ config, lib, fetchurl, appimageTools, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        android-tools
	    heimdall
        flashrom
 ];
}