{
  system,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    helix
    git
    git-lfs
    jujutsu
    nushell
    nil
    nixd
    nixfmt-rfc-style
    alejandra
    wget
    tree
    just
    just-lsp
    cmake
    fzf
    ripgrep
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "${system}";

  nix.package = pkgs.nixVersions.stable; # or pkgs.nixUnstable
}
