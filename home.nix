{
  lib,
  pkgs,
  osConfig,
  config,
  self,
  ...
}: let
  configPath = "${config.home.homeDirectory}/git/config";
  mkMutableSymlink = path:
    config.lib.file.mkOutOfStoreSymlink
    (configPath + lib.removePrefix (toString self) (toString path));
in {
  home = {
    stateVersion = "25.05";
    packages = with pkgs; [
    ];
    # Map everything in the `config` directory in this
    # repository to the `.config` in my home directory
    file.".config" = {
      source = ./config;
      recursive = true;
    };
    # Doom is a git submodule
    # file.".config/emacs" = {
    #   source = mkMutableSymlink ./config/emacs;
    #   recursive = true;
    # };
  };

  programs.home-manager.enable = true;
  xdg.enable = true;

  imports = [
    ./apps/git.nix
    ./apps/nushell.nix
    ./apps/helix
  ];

  xdg.configFile."ghostty/config".text = ''
    font-family = "Zed Mono"  #MonoLisa
    copy-on-select = clipboard
    quit-after-last-window-closed = true
    window-inherit-font-size = true
    font-size = 16
    command = "${pkgs.nushell}/bin/nu"
  '';
}
