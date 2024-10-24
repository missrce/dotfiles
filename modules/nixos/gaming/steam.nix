{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.missos.programs.gaming.steam;
in {
  options.missos.programs.gaming.steam.enable = mkEnableOption "Steam";

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin.steamcompattool];
    };
  };
}
