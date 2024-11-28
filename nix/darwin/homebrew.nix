{ ... }: {
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
