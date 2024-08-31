{inputs, ...}: {
  perSystem = {system, ...}: let
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  in {
    _module.args = {
      pkgs = import inputs.nixpkgs {inherit system config;};
      pkgs-unstable = import inputs.nixpkgs-unstable {inherit system config;};
      pkgs-master = import inputs.nixpkgs-master {inherit system config;};
    };
  };

  systems = import inputs.systems;

  imports = [
    ./dev # Development tooling for the flake
  ];
}
