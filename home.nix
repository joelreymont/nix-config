{
  lib,
  pkgs,
  osConfig,
  ...
}:

{
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    helix
    git
    jujutsu
    nushell
    ghostty
  ];

  programs.git = {

    enable = true;
    userName = "name";
    userEmail = "mail@example.org";
    extraConfig = {
      github.user = "<user>";
      init = {
        defaultBranch = "trunk";
      };
      diff = {
        external = "${pkgs.difftastic}/bin/difft";
      };
    };
  };
}
