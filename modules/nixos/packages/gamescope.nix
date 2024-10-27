{ config, lib, ... }:
let
  inherit (lib.modules) mkIf;
in
{
  programs.gamescope = mkIf config.missos.system.interface.graphical {
    enable = true;
    capSysNice = true;
  };
}
