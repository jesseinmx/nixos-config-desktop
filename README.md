Usual flake workflow from now on
# Update inputs (pinned to 25.05 branches)
nix flake update

# Rebuild this host
sudo nixos-rebuild switch --flake .#nixos

# Test the NixOS configuration
# When you ask to test, please specify if you want to test NixOS or Home Manager.
nix eval .#nixosConfigurations.nixos.config.system.stateVersion
nixos-rebuild build --flake .#nixos

# Test the Home Manager configuration
home-manager switch --flake . --dry-run

# Apply the home-manager configuration
home-manager switch --flake .
