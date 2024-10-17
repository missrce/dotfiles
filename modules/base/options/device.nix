{lib, ...}: let
  inherit (lib.types) enum string nullOr;
  inherit (lib.options) mkOption;
in {
  options.missos = {
    device = {
      primaryRenderDevice = mkOption {
        type = nullOr string;
      };
      type = mkOption {
        type = enum [
          "laptop"
          "desktop"
          "server"
        ];
      };
    };
  };
}
