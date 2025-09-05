{
  description = "nixos-config-desktop (minimal flake, all imports live in configuration.nix)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      # Name this whatever you want to target with --flake .#<name>
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        # Pass flake inputs into your modules so configuration.nix can use them.
        specialArgs = { inherit home-manager; };
        modules = [ ./configuration.nix ];
      };
    };
  };
}

