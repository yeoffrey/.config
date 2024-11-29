{ pkgs, ... }:

{
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "geoff";

    homeDirectory = "/Users/geoff";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.05";

    sessionVariables = { EDITOR = "nvim"; };

    packages = [ ];
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    lazygit.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = { enable = true; };
      syntaxHighlighting.enable = true;
      initExtra = ''
        export PATH="/Users/geoff/google-cloud-sdk/bin:$PATH"

        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
      shellAliases = {
        nix-update = "nix flake update --flake ~/.config/nix";
        nix-switch = "darwin-rebuild switch --flake ~/.config/nix#air";
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      userName = "Geoffrey Belcher";
      userEmail = "geoffreybelcher@icloud.com";
    };
  };
}
