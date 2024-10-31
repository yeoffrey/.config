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

    packages = [ pkgs.zoxide ];
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = { enable = true; };
      syntaxHighlighting.enable = true;
      initExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
      shellAliases = { z = "cd"; };
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
