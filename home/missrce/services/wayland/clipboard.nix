{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.meta) getExe getExe';
  inherit (lib.modules) mkIf;
  inherit (lib.services) mkGraphicalService;

  inherit (osConfig.missos) system environment;
in {
  config = mkIf (system.interface.graphical && environment.isWM) {
    systemd.user.services.cliphist = mkGraphicalService {
      Unit.Description = "Clipboard history service";
      Service = {
        ExecStart = "${getExe' pkgs.wl-clipboard "wl-paste"} --watch ${getExe pkgs.cliphist} store";
        Restart = "always";
      };
    };
    systemd.user.services.clear-clipboard = {
      description = "Clear clipboard history on boot";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${getExe pkgs.cliphist} wipe";
        RemainAfterExit = "yes";
      };
    };
  };
}
