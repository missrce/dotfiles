{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = mkIf config.missos.system.interface.graphical true;
}
