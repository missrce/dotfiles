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
      builders = import ./builders.nix {inherit lib inputs withSystem;};
      validators = import ./validators.nix;
    }
  );

  extendedLib = customLib.extend (_: _: originalLib);
in {
  flake.lib = extendedLib;
  perSystem._module.args.lib = extendedLib;
}