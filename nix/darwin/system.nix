{ pkgs, ... }: {
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
}
