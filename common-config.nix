{
  system,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
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
    ast-grep
    ruff
    gh
    fd
    lazygit
    ansifilter
    stow
    neovim
    # development
    (rust-bin.stable.latest.default.override
      {
        extensions = ["rust-analyzer"];
      })
    (python3.withPackages (python-pkgs: []))
    cmake
    gfortran
    libiconv
    lua
    luarocks
    stylua
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
