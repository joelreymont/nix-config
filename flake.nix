# On a new Mac:
#   sudo nix run nix-darwin -- switch --flake .
# Or to update:
#   nix flake update
#   sudo darwin-rebuild switch --flake .
{
  description = "Joel's nix-darwin system flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nix-darwin,
    home-manager,
    nixpkgs,
  }: let
    platform = "aarch64-darwin";
  in let
    pkgs = nixpkgs.legacyPackages.${platform};
  in let
    host = builtins.readFile (
      pkgs.runCommand "hostname" {} ''
        /usr/sbin/scutil --get LocalHostName|tr -d '\n' > $out
      ''
    );
  in {
    # darwin-rebuild build --flake .
    darwinConfigurations.${host} = nix-darwin.lib.darwinSystem {
      modules = [
        (import ./config.nix {
          inherit
            self
            platform
            pkgs
            host
            ;
        })

        home-manager.darwinModules.home-manager
        {
          # `home-manager` config
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.joel = ./home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.${host}.pkgs;
  };
}
