{
  lib,
  pkgs,
  osConfig,
  ...
}: {
  home = {
    stateVersion = "25.05";
    # packages = with pkgs; [
    # ];
    # Map everything in the `config` directory in this
    # repository to the `.config` in my home directory
    file.".config" = {
      source = ./config;
      recursive = true;
    };
  };

  programs.home-manager.enable = true;
  xdg.enable = true;

  programs.nushell = {
    enable = true;

    loginFile.text = ''
      ssh-add --apple-load-keychain out+err> /dev/null
    '';

    configFile.text = ''
      use std/util "path add"

      path add "~/.local/bin"
      path add "~/.cargo/bin"
      path add "~/.nix-profile/bin"
      path add "/nix/var/nix/profiles/default/bin"
      path add "/run/current-system/sw/bin"
      path add "/opt/homebrew/bin"
      path add "/usr/local/bin"

      alias g = git
    '';

    envFile.text = ''
      $env.config.show_banner = false

      $env.config.history = {
        file_format: sqlite
        max_size: 1_000_000
        sync_on_enter: true
        isolation: true
      }

      $env.EDITOR = 'hx'
      $env.CARGO_PROFILE_DEV_BUILD_OVERRIDE_DEBUG = true
    '';
  };

  xdg.configFile."ghostty/config".text = ''
    font-family = "Zed Mono"  #MonoLisa
    copy-on-select = clipboard
    quit-after-last-window-closed = true
    window-inherit-font-size = true
    font-size = 16
    command = "${pkgs.nushell}/bin/nu"
  '';

  # programs.git = {
  #   enable = true;
  #   userName = "name";
  #   userEmail = "mail@example.org";
  #   extraConfig = {
  #     github.user = "<user>";
  #     init = {
  #       defaultBranch = "trunk";
  #     };
  #     diff = {
  #       external = "${pkgs.difftastic}/bin/difft";
  #     };
  #   };
  # };
}
