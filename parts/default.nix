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
    ./lib # Custom functions inside the flake applied to the global lib
    ./dev # Development tooling for the flake
    ./packages # Custom packages

    ../systems # System configurations
  ];
}
