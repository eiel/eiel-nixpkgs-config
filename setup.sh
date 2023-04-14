#/bin/sh

cat <<EOF > ~/.config/nixpkgs/darwin-configuration.nix
import ${PDW}/darwin-configuration.nix
EOF

cat <<EOF > ~/.config/home-manager/home.nix
import ${PDW}/home-overlay.nix "$USER"
EOF
