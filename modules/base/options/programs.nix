{lib, ...}: let
  inherit (lib.types) enum;
  inherit (lib.options) mkOption mkEnableOption;
in {
  options.missos.programs = {
    browser = {
      chromium = mkEnableOption "Chromium browser";
      firefox = mkEnableOption "Mozilla Firefox browser";
    };
    launcher = mkOption {
      type = enum [
        "fuzzel"
      ];
      default = "fuzzel";
    };
    terminal = mkOption {
      type = enum [
        "foot"
      ];
      default = "foot";
    };
  };
}
