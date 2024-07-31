mkdir ~/.config
mkdir ~/.local
mkdir ~/.local/share

ln -s ~/Projects/nix/sway/config/fuzzel ~/.config/fuzzel
ln -s ~/Projects/nix/sway/config/foot ~/.config/foot
ln -s ~/Projects/nix/sway/config/gtk-3.0 ~/.config/gtk-3.0
ln -s ~/Projects/nix/sway/config/gtk-4.0 ~/.config/gtk-4.0
ln -s ~/Projects/nix/sway/config/sway ~/.config/sway

ln -s ~/Projects/nix/sway/applications ~/.local/share/applications

ln -s ~/Projects/nix/helix ~/.config/helix

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak -y install org.gtk.Gtk3theme.Arc-Dark
flatpak -y install org.telegram.desktop
flatpak -y install com.axosoft.GitKraken
flatpak -y install com.github.tchx84.Flatseal

sudo flatpak override --env=GTK_THEME=Arc-Dark

ssh-keygen -t ed25519 -C "mike@membervault.co"
git config --global user.email "mike@membervault.co"
git config --global user.name "Mike Kelly"

git -C ~/Projects/nix remote set-url origin git@github.com:mkellyxp/nix.git
# git -C /var/www/vip_member_vault_admin remote set-url origin git@github.com:mkellyxp/vip_member_vault_admin.git
# git -C /var/www/vip_member_vault remote set-url origin git@github.com:mkellyxp/vip_member_vault.git
# git -C /var/www/public_site_2023 remote set-url origin git@github.com:mkellyxp/public_site_2023.git

sudo mkdir /var/www
sudo chown -R nginx:nginx /var/www
sudo chmod -R 775 /var/www

sudo mariadb -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'n3wj3rs3y'"
sudo mariadb -uroot -e "flush privileges"

echo 'Set your local user in config to:'
echo 'extraGroups = [ "networkmanager" "wheel" "video" "nginx" ];';
echo ' '
echo 'Remember to set your SSH key in Github!'
