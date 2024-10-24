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
  options.missos.programs.gaming.steam.enable = mkEnableOption "Steam";

  config.programs.steam = mkIf cfg.enable {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin.steamcompattool ];
  };
}
