{ osConfig, lib, ... }:
let
  inherit (lib.modules) mkIf;
in
{
  config = mkIf osConfig.missos.system.interface.graphical {
    # https://github.com/nix-community/home-manager/issues/2064
    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
    };
  };
}
