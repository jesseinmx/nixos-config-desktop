Usual flake workflow from now on
# Update inputs (pinned to 25.05 branches)
nix flake update

# Rebuild this host
sudo nixos-rebuild switch --flake .#nixos

# Test the configuration
nix eval .#nixos.config.system.stateVersion
nixos-rebuild build --flake .#nixos
home-manager switch --flake . --dry-run

# Apply the home-manager configuration
home-manager switch --flake .
