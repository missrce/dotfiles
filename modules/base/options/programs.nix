{lib, ...}: let
  inherit (lib.types) nullOr enum;
  inherit (lib.options) mkEnableOption mkOption;
in {
  options.missos.programs = {
    browser = mkOption {
      type = nullOr (enum [
        "chromium"
        "firefox"
      ]);
      default = "chromium";
    };
    launcher = mkOption {
      type = nullOr (enum [
        "fuzzel"
      ]);
      default = "fuzzel";
    };
    terminal = mkOption {
      type = nullOr (enum [
        "foot"
      ]);
      default = "foot";
    };
    games = {
      minecraft = mkEnableOption "Enable Minecraft";
      steam = mkEnableOption "Enable Steam";
    };
  };
}
