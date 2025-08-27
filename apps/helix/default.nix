{pkgs, ...}:
with pkgs; {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [nixd];

    settings = {
      theme = "gruvbox_light";

      editor = {
        soft-wrap = {
          enable = true;
        };
        lsp = {
          display-inlay-hints = true;
        };
      };
    };
    languages = import ./languages.nix {
      inherit
        pkgs
        lib
        ;
    };
  };
}
