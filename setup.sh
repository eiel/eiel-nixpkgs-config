#/bin/sh

cat <<EOF > user.nix
{
  name = "${USER}";
}
EOF
