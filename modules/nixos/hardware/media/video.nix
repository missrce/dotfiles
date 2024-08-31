{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.hardware) isx86Linux;
in {
  config = mkIf config.missos.system.interface.graphical {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = isx86Linux pkgs;
      };
    };

    # benchmarking tools
    environment.systemPackages = builtins.attrValues {inherit (pkgs) glxinfo glmark2;};
  };
}
