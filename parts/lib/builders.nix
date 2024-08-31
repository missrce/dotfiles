{
  inputs,
  withSystem,
  ...
}: let
  inherit (inputs) self;
  inherit (self) lib;

  inherit (lib) nixosSystem;
  inherit (lib.lists) singleton concatLists;
  inherit (lib.attrsets) recursiveUpdate listToAttrs;

  mkSystem = {
    host,
    arch ? "x86_64",
    target ? "nixos",
    modules ? [],
    specialArgs ? {},
  }: let
    system =
      if (target == "nixos" || target == "iso")
      then "${arch}-linux"
      else "${arch}-${target}";
  in
    withSystem system (
      {
        self',
        inputs',
        ...
      }:
        nixosSystem {
          inherit system;
          specialArgs =
            recursiveUpdate {
              inherit lib self self' inputs inputs';
            }
            specialArgs;

          modules = concatLists [
            ["${self}/modules/${target}/default.nix"]
            ["${self}/hosts/${host}/default.nix"]
            (singleton {
              networking.hostName = host;
            })
            modules
          ];
        }
    );

  mkSystems = systems:
    listToAttrs (
      map (system: {
        name = system.host;
        value = mkSystem system;
      })
      systems
    );
in {
  inherit mkSystem mkSystems;
}
