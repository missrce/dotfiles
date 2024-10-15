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
    systemd.user.services.clear-clipboard = mkGraphicalService {
      Unit = {
        Description = "Clipboard history service";
        Requires = ["cliphist.service"];
        After = ["cliphist.service"];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${getExe pkgs.cliphist} wipe";
        RemainAfterExit = "no";
      };
    };
  };
}
