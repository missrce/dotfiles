{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (config.missos) environment;
  inherit (lib.modules) mkIf mkForce;
in {
  config =
    mkIf environment.loginManager
    == "sddm" {
      services.displayManager.sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm; # allow qt6 themes to work
        wayland.enable = true; # run under wayland rather than X11
        settings.General.InputMethod = "";
      };
      systemd.services.display-manager = {
        wants = mkForce [
          "systemd-user-sessions.service"
        ];
        after = mkForce [
          "systemd-user-sessions.service"
          "getty@tty1.service"
          "plymouth-quit.service"
          "systemd-logind.service"
        ];
        conflicts = mkForce [
          "getty@tty1.service"
        ];
      };
    };
}
