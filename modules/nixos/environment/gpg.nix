{config, pkgs, lib, ...}: let
  inherit (lib.modules) mkIf;
  inherit (config.missos.system.interface) graphical;
in {
  services.dbus.packages = mkIf graphical [ pkgs.gcr ];
}
