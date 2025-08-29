# On a new Mac:
#   sudo nix run nix-darwin -- switch --flake .
# Or to update:
#   nix flake update
#   sudo darwin-rebuild switch --flake .
{
  description = "Joel's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      home-manager,
      nixpkgs,
    }:
    # darwin-rebuild build --flake .
    let
      commonModules = [
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.joel = ./home.nix;
        }
      ];
      darwinSystem = nix-darwin.lib.darwinSystem rec {
        system = "aarch64-darwin";
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ./common-config.nix
          ./darwin-config.nix
          home-manager.darwinModules.home-manager
        ]
        ++ commonModules;
      };
      nixosSystem = nixpkgs.lib.nixosSystem rec {
        system = "aarch64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ./common-config.nix
          ./nixos-config.nix
          home-manager.nixosModules.home-manager
        ]
        ++ commonModules;
      };
    in
    {
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      packages.aarch64-darwin.darwinConfigurations.weltbau = darwinSystem;
      packages.aarch64-darwin.darwinConfigurations.calavera = darwinSystem;
      packages.aarch64-linux.nixosConfigurations.nixos = nixosSystem;
    };
}
