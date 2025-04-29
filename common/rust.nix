{ config, lib, fetchurl, appimageTools, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      gtk4
      pkg-config
      rustc
      cargo
      glib
 ];
}

