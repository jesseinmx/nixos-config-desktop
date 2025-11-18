Usual flake workflow from now on
# Update inputs (pinned to 25.05 branches)
nix flake update

# Rebuild this host
sudo nixos-rebuild switch --flake .#JessBot

# Test the NixOS configuration
# When you ask to test, please specify if you want to test NixOS or Home Manager.
nix eval .#nixosConfigurations.JessBot.config.system.stateVersion
nixos-rebuild build --flake .#JessBot

# Test the Home Manager configuration
home-manager switch --flake .#jesseinmx --dry-run

# Apply the home-manager configuration
home-manager switch --flake .#jesseinmx
