{
  pkgs,
  lib,
  ...
}:
with pkgs; let
  inherit
    (lib)
    getExe
    ;

  auto-format = true;

  indent = {
    tab-width = 2;
    unit = "  ";
  };
in {
  language = [
    {
      inherit auto-format indent;
      name = "nix";

      language-servers = ["nixd"];

      formatter = {
        command = getExe alejandra;
      };
    }
  ];
  language-server = {
    nixd = {
      command = "nixd";
      args = ["--semantic-tokens=true"];
      config.nixd = let
        myFlake = "(builtins.getFlake (toString ~/Work/Nix/nix-config))";
        nixosOpts = "${myFlake}.nixosConfigurations.manin.options";
      in {
        nixpkgs.expr = "import ${myFlake}.inputs.nixpkgs { }";
        formatting.command = ["alejandra"];
        options = {
          nixos.expr = nixosOpts;
          home-manager.expr = "${nixosOpts}.home-manager.users.type.getSubOptions []";
        };
      };
    };
  };
}
