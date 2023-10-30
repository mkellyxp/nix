{ config, lib, fetchurl, appimageTools, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        elixir
        inotify-tools
 ];
}