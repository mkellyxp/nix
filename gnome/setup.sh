# Set up helix
rm -R ~/.config/helix
ln -s ~/Projects/nix/helix ~/.config/helix

# Gnome settings
dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
dconf write /org/gnome/desktop/peripherals/touchpad/two-finger-scrolling-enabled true
dconf write /org/gnome/desktop/peripherals/touchpad/natural-scroll false
dconf write /org/gnome/desktop/interface/enable-hot-corners false
dconf write /org/gnome/mutter/dynamic-workspaces false
dconf write /org/gnome/desktop/wm/preferences/num-workspaces 5
dconf write /org/gnome/desktop/interface/show-battery-percentage true
dconf write /org/gnome/desktop/notifications/application/org-gnome-software/enable false
dconf write /org/gnome/desktop/search-providers/disabled "['org.gnome.Software.desktop']"


dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "@as []"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "['<Super>1']"
dconf write /org/gnome/shell/keybindings/switch-to-application-1 "@as []"

dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "@as []"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "['<Super>2']"
dconf write /org/gnome/shell/keybindings/switch-to-application-2 "@as []"

dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "@as []"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "['<Super>3']"
dconf write /org/gnome/shell/keybindings/switch-to-application-3 "@as []"

dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "@as []"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "['<Super>4']"
dconf write /org/gnome/shell/keybindings/switch-to-application-4 "@as []"

dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-last "@as []"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-last "['<Super>0']"

dconf write /org/gnome/desktop/interface/icon-theme "'Papirus-Dark'"
dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita-dark'"
dconf write /org/gnome/desktop/interface/clock-format "'12h'"
dconf write /org/gtk/settings/file-chooser/clock-format "'12h'"
dconf write /org/gnome/desktop/interface/enable-animations false
dconf write /org/gnome/shell/enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com']"

gsettings set org.gnome.desktop.privacy remember-recent-files false

# Flatpaks
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.spotify.Client org.telegram.desktop org.signal.Signal

# MV Dev Stuff
sudo mkdir /var/www
sudo chown -R nginx:nginx /var/www
sudo chmod -R 775 /var/www

sudo mariadb -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'n3wj3rs3y'"
sudo mariadb -uroot -e "flush privileges"

echo 'Set your local user in config to:'
echo 'extraGroups = [ "networkmanager" "wheel" "nginx" ];';
