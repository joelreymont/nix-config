{
  config,
  system,
  pkgs,
  ...
}:
{
  homebrew = {
    enable = false;
    onActivation.cleanup = "uninstall";
    taps = [ ];
    brews = [
    ];
    casks = [
    ];
  };
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # Let Determinate Nix handle Nix configuration
  nix.enable = false;

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    screencapture.location = "~/Desktop";
    screensaver.askForPasswordDelay = 10;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # Disable press and hold for diacritics.
  # I want to be able to press and hold j and k
  # in VSCode with vim keys to move around.
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;

  system.primaryUser = "joel";

  # Required by Home Manager
  users.users.joel.home = "/Users/joel";
}
