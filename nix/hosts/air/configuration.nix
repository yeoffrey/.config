{ pkgs, userConfig, ... }: {
  nixpkgs = {
    # The platform the configuration will be used on.
    hostPlatform = "aarch64-darwin";
    # Allow non-opensource packages
    config.allowUnfree = true;
  };

  # home-manager
  users.users.${userConfig.name} = {
    name = "${userConfig.name}";
    home = "/Users/${userConfig.name}";
  };

  # Necessary for using flakes on this system.
  nix = {
    package = pkgs.nix;
    settings.experimental-features = "nix-command flakes";
    optimise.automatic = true;
    configureBuildUsers = true;
  };

  # System Settings
  system = {
    defaults = {
      dock = {
        autohide = true;
        expose-animation-duration = 0.15;
        show-recents = false;
        showhidden = true;
        persistent-apps = [
          "${pkgs.arc-browser}/Applications/arc.app"
          "/System/Applications/Messages.app"
        ];
      };
      finder = {
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirst = true;
      };
      loginwindow = { GuestEnabled = false; };
      screencapture = {
        location = "~/Pictures/screenshots";
        type = "png";
        disable-shadow = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  services.nix-daemon.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  # System packages
  environment.systemPackages = with pkgs; [
    wget
    fd
    ripgrep
    tmux
    neovim
    gh
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
    spotify
    postman
    wezterm
  ];

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    casks = [
      "raycast"
      "1password"
      "1password-cli"
      "notion"
      "todoist"
      "scroll-reverser"
      "figma"
    ];
    taps = [ ];
    onActivation.cleanup = "zap";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
