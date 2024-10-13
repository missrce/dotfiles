{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.missos.environment) loginManager;
  inherit (lib.modules) mkIf;
in {
  services.displayManager.sddm = mkIf (loginManager == "sddm") {
    enable = true;
    package = pkgs.kdePackages.sddm; # allow qt6 themes to work
    wayland.enable = true; # run under wayland rather than X11
    settings.General.InputMethod = "";
  };
}
