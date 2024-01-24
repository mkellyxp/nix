{ config, lib, fetchurl, appimageTools, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        elixir
        elixir-ls
        inotify-tools
 ];
}
