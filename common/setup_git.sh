mkdir ~/.config

ln -s ~/Projects/nix/helix ~/.config/helix

ssh-keygen -t ed25519 -C "mike@membervault.co"
git config --global user.email "mike@membervault.co"
git config --global user.name "Mike Kelly"

git -C ~/Projects/nix remote set-url origin git@github.com:mkellyxp/nix.git
