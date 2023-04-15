#/bin/sh

mkdir -p ~/.nixpkgs
cat <<EOF > ~/.nixpkgs/darwin-configuration.nix
import ${PWD}/darwin-configuration.nix
EOF

mkdir -p ~/.config/home-manager
cat <<EOF > ~/.config/home-manager/home.nix
import ${PWD}/home.nix "$USER"
EOF
