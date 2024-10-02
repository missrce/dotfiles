{
  inputs,
  withSystem,
  ...
}: let
  originalLib = inputs.nixpkgs.lib;

  customLib = originalLib.makeExtensible (
    self: let
      lib = self;
    in {
      secrets = import ./secrets.nix {inherit inputs;};
      services = import ./services.nix {inherit lib;};
      builders = import ./builders.nix {inherit lib inputs withSystem;};
      validators = import ./validators.nix;
    }
  );

  extendedLib = customLib.extend (_: _: originalLib.extend (_: _: inputs.home-manager.lib));
in {
  flake.lib = extendedLib;
  perSystem._module.args.lib = extendedLib;
}
