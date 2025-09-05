Usual flake workflow from now on
# Update inputs (pinned to 25.05 branches)
nix flake update

# Rebuild this host
sudo nixos-rebuild switch --flake .#nixos
