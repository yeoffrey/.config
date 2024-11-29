{
  description = "Nix-darwin configurations for my machines";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-darwin (flakes for MacOS machines)
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homebrew
    homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = { self, nixpkgs, home-manager, darwin, homebrew }@inputs:
    let
      # Function for nix-darwin system configuration
      mkDarwinConfiguration = hostname: username:
        darwin.lib.darwinSystem {
          modules = [
            home-manager.darwinModules.home-manager
            homebrew.darwinModules.nix-homebrew
            ./hosts/${hostname}/configuration.nix
            ./users/${username}.nix
          ];
        };
    in {
      darwinConfigurations."air" = darwin.lib.darwinSystem {
        modules = [
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.geoff = import ./users/geoff.nix;
            };
          }
          home-manager.darwinModules.home-manager
          homebrew.darwinModules.nix-homebrew
          ./hosts/air/configuration.nix
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."air".pkgs;
    };
}
