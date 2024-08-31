{lib, ...}: let
  inherit (lib.types) enum;
  inherit (lib.options) mkOption;
in {
  options.missos.device.type = mkOption {
    type = enum [
      "laptop"
      "desktop"
      "server"
    ];
  };
}
