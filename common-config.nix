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
    uv
    tree
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
