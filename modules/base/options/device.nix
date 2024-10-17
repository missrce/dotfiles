{lib, ...}: let
  inherit (lib.types) enum str nullOr;
  inherit (lib.options) mkOption;
in {
  options.missos = {
    device = {
      primaryRenderDevice = mkOption {
        type = nullOr str;
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
