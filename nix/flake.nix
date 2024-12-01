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
      inherit (self) outputs;

      # Define user configurations
      users = {
        geoff = {
          email = "geoffreybelcher@icloud.com";
          fullName = "Geoffrey Belcher";
          name = "geoff";
        };
      };

      # Function for nix-darwin system configuration
      mkDarwinConfiguration = hostname: username:
        darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
          };
          modules = [
            home-manager.darwinModules.home-manager
            homebrew.darwinModules.nix-homebrew
            ./hosts/${hostname}/configuration.nix
          ];
        };

      # Function for Home Manager configuration
      mkHomeConfiguration = system: username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = {
            inherit inputs outputs;
            userConfig = users.${username};
          };
          modules = [ ./users/${username}.nix ];
        };
    in {
      darwinConfigurations = { "air" = mkDarwinConfiguration "air" "geoff"; };

      homeConfigurations = {
        "geoff@air" = mkHomeConfiguration "aarch64-darwin" "geoff" "air";
      };
    };
}
