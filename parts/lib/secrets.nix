{inputs, ...}: let
  inherit (inputs) self;

  defaults = {
    owner = "root";
    group = "root";
    mode = "400";
  };

  mkSecret = {
    file,
    owner ? defaults.owner,
    group ? defaults.group,
    mode ? defaults.mode,
    ...
  }: {
    file = "${self}/secrets/${file}.age";
    inherit owner group mode;
  };

  mkSecretWithPath = {
    file,
    path,
    owner ? defaults.owner,
    group ? defaults.group,
    mode ? defaults.mode,
    ...
  }:
    mkSecret {
      inherit file owner group mode;
    }
    // {
      inherit path;
    };
in {
  inherit mkSecret mkSecretWithPath;
}
