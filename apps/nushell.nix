{
  config,
  pkgs,
  ...
}: {
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

      def logcopy [path: string] { nix log $path | asciifilter | pbcopy }
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
}
