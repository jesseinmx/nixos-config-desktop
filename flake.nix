{
  description = "nixos-config-desktop (flake with Home Manager)";

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
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          # Your system config (must NOT reference `home-manager`)
          ./configuration.nix

          # Import Home Manager as a NixOS module HERE (and only here)
          home-manager.nixosModules.home-manager

          # Minimal HM integration + point to your home.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.jesseinmx = import ./home.nix;
          }
        ];
      };
    };
  };
}

