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

  outputs = inputs@{ self, nixpkgs, home-manager, darwin, homebrew }:
    let
      configuration = { pkgs, ... }: {
        nixpkgs = {
          # The platform the configuration will be used on.
          hostPlatform = "aarch64-darwin";
          # Allow non-opensource packages
          config.allowUnfree = true;
        };

        environment.systemPackages = with pkgs; [
          wget
          fd
          ripgrep
          tmux
          neovim
          iterm2

          # Tooling
          lazygit

          # Lang
          nodejs_20
          go
          cargo
          poetry
          pyenv
          rust-analyzer
          nixfmt-classic
          magic-wormhole-rs
          terraform
          deno

          obsidian
          vscode
          slack
        ];

        # home-manager
        users.users.geoff.home = "/Users/geoff";
        home-manager.backupFileExtension = "backup";

        # Necessary for using flakes on this system.
        nix = {
          settings.experimental-features = "nix-command flakes";
          configureBuildUsers = true;
          useDaemon = true;
        };

        # Fonts
        fonts.packages =
          [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

        programs.zsh.enable = true;

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        security.pam.enableSudoTouchIdAuth = true;
      };
    in {
      darwinConfigurations."air" = darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.geoff = import ./home.nix;
            };
          }
          homebrew.darwinModules.nix-homebrew
          ./darwin/homebrew.nix
          ./darwin/system.nix
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."air".pkgs;
    };
}
