{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  inherit (osConfig.missos) system environment;
in {
  config = mkIf (system.interface.graphical && environment.isWM) {
    home.packages = builtins.attrValues {
      inherit (pkgs)
        wl-clipboard
        cliphist
        ;
    };
  };
}
