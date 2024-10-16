{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.missos.programs = {
    games = {
      steam = mkEnableOption "Enable Steam";
    };
  };
}
