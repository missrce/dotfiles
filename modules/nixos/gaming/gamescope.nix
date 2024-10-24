{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.missos.programs.gaming.gamescope;
in {
  options.missos.programs.gaming.gamescope.enable = mkEnableOption "gamescope compositing manager";

  config.programs.gamescope = mkIf cfg.enable {
    enable = true;
    capSysNice = true;
  };
}
