{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (config.missos) environment;
  inherit (lib.modules) mkOverride mkIf;
in {
  config = mkIf (environment.loginManager == "sddm") {
    systemd.services.display-manager = {
      serviceConfig = {
        Restart = mkOverride 50 "on-failure";
        TimeoutStopSec = 1;
        SendSIGHUP = true;
      };
      after = [
        "getty@tty1.service"
      ];
      conflicts = [
        "getty@tty1.service"
      ];
    };
    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm; # allow qt6 themes to work
      wayland.enable = true; # run under wayland rather than X11
      settings.General.InputMethod = "";
    };
  };
}
