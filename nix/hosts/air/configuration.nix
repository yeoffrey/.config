{ pkgs, ... }: {
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

    gh

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

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;

    # Common system settings
    defaults = {
      dock = {
        autohide = true;
        mru-spaces = false;
        persistent-apps = [
          "${pkgs.arc-browser}/Applications/arc.app"
          "/System/Applications/Mail.app"
          "/System/Applications/Calendar.app"
          "${pkgs.slack}/Applications/slack.app"
          "/System/Applications/Messages.app"
          "${pkgs.iterm2}/Applications/iterm2.app"
        ];
        persistent-others = [ ];
        show-recents = false;
      };
      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "Nlsv";
        CreateDesktop = false;
        ShowPathbar = true;
      };
      loginwindow = { GuestEnabled = false; };
      screencapture.location = "~/Pictures/screenshots";
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    casks = [
      "raycast"
      "1password"
      "1password-cli"
      "notion"
      "todoist"
      "scroll-reverser"
      "figma"
      "postman"
      "spotify"
      "wezterm"
    ];
  };

}
