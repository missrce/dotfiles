{lib, ...}: let
  inherit (lib.types) enum;
  inherit (lib.options) mkOption mkEnableOption;
in {
  options.missos = {
    device.type = mkOption {
      type = enum [
        "laptop"
        "desktop"
        "server"
      ];
    };
    system.interface.graphical =
      mkEnableOption "Graphical user interface"
      // {
        default = false;
      };
  };
}
