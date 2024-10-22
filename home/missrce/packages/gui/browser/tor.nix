{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  inherit (osConfig.missos.system.interface) graphical;
in {
  home.packages = mkIf graphical (with pkgs; [
    tor-browser
  ]);
}
