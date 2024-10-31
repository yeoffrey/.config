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
          "/System/Applications/Messages.app/"
        ];
      };
      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "Nlsv";
      };
      screencapture.location = "~/Pictures/screenshots";
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
}
