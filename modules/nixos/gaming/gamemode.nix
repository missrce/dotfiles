{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.missos.programs.gaming;
in
{
  options.missos.programs.gaming.gamemode.enable = mkEnableOption "gamemode, optimization tools";

  config.programs.gamemode = mkIf cfg.enable {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 15;
      };
      custom = {
        start = "${lib.meta.getExe pkgs.libnotify} -a 'Gamemode' 'Optimizations activated'";
        end = "${lib.meta.getExe pkgs.libnotify} -a 'Gamemode' 'Optimizations deactivated'";
      };
    };
  };
}
