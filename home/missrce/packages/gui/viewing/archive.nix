{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  inherit (osConfig.missos.system.interface) graphical;
in {
  config = mkIf graphical {
    home.packages = with pkgs; [file-roller];
  };
}
