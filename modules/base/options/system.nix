{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.missos = {
    system.interface.graphical =
      mkEnableOption "Graphical user interface"
      // {
        default = false;
      };
  };
}
