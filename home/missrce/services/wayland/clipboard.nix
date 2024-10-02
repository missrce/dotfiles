{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.meta) getExe getExe';
  inherit (lib.modules) mkIf;
  inherit (lib.services) mkGraphicalService;
in
{
  config = mkIf osConfig.missos.system.interface.graphical {
    systemd.user.services.cliphist = mkGraphicalService {
      Unit.Description = "Clipboard history service";
      Service = {
        ExecStart = "${getExe' pkgs.wl-clipboard "wl-paste"} --watch ${getExe pkgs.cliphist} store";
        Restart = "always";
      };
    };
  };
}
