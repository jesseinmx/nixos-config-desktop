{
  description = "nixos-config-desktop (flake with Home Manager)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, ... }@inputs: # <-- Note the @inputs
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ (import ./overlays/antigravity-override.nix) ];
    };
  in {
    # 1. NIXOS CONFIGURATION (SYSTEM-ONLY)
    #    Build with: sudo nixos-rebuild switch --flake .#JessBot
    nixosConfigurations = {
      JessBot = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; }; # Pass flake inputs to modules
        modules = [
          # Your system config, now completely decoupled from home-manager
          ./configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
    };

    # 2. HOME-MANAGER CONFIGURATION (USER-ONLY)
    #    Deploy with: home-manager switch --flake .#jesseinmx
    homeConfigurations = {
      jesseinmx = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to modules
        modules = [ ./home/jesseinmx/default.nix { nixpkgs.config.allowUnfree = true; } ];
      };
    };
  };
}
