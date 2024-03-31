{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        mate.mate-polkit
        fuzzel
        foot
        kitty
        slurp
        grim
        xfce.thunar
        xfce.tumbler
        ffmpegthumbnailer
        gthumb
        gnome.gnome-disk-utility
        arc-theme
        xorg.xlsclients
        xdg-utils
        glib
        bc
        swaylock
        swayidle
        wl-clipboard
        playerctl
        bluetuith
        libnotify
        mako
        unzip
        ripgrep
        fzf
        fd
    ];

    hardware.bluetooth.enable = true;

    services.dbus.enable = true;
    programs.light.enable = true;

    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
    };
}

## NOTES ##
#
# For backlight control without sudo, add user to video group
#   users.users.mkelly = {
#       isNormalUser = true;
#       description = "Mike Kelly";
#       extraGroups = [ "networkmanager" "wheel" "video" "nginx" ];
#       packages = with pkgs; [];
#   };
#
# To launch chromium apps in wayland, add:
# 	--enable-features=UseOzonePlatform --ozone-platform=wayland
#
#   Can copy .desktop files from: /run/current-system/sw/share/applications/
#	to: ~/.local/share/applications
#
# To get list of audio outputs and switch
#   wpctl status
#   wpctl set-default <ID>
#   WIP: pw-dump | jq '.[] | select(.info.props."media.class" == "Audio/Sink") | .id'
#
# For SSH setup and git
#   ssh-keygen -t ed25519 -C "your_email@example.com"
#   eval "$(ssh-agent -s)"
#   ssh-add ~/.ssh/id_ed25519
#   git config --global user.email "mike@membervault.co"
#   git config --global user.name "Mike Kelly"
#   (go to github, settings / access)
#   
#   In every session to not have to type password over and over:
#   eval "$(ssh-agent -s)"
#   ssh-add ~/.ssh/id_ed25519
