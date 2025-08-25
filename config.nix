{
  self,
  platform,
  pkgs,
  ...
}:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    helix
    git
    jujutsu
    nushell
    nil
    nixd
    alejandra
  ];

  homebrew = {
    enable = false;
    # onActivation.cleanup = "uninstall";

    taps = [ ];
    brews = [
    ];
    casks = [
    ];
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  security.pam.services.sudo_local.touchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "${platform}";

  nix.package = pkgs.nixFlakes; # or pkgs.nixUnstable

  # Let Determinate Nix handle Nix configuration
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;

  system.primaryUser = "joel";

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    screencapture.location = "~/Desktop";
    screensaver.askForPasswordDelay = 10;
  };

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # Disable press and hold for diacritics.
  # I want to be able to press and hold j and k
  # in VSCode with vim keys to move around.
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;

  # Required by Home Manager
  users.users.joel.home = "/Users/joel";
}
