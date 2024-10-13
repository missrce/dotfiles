{lib, ...}: let
  inherit (lib.types) enum;
  inherit (lib.options) mkOption;
in {
  options.missos.programs = {
    browser = mkOption {
      type = enum [
        "chromium"
        "firefox"
      ];
      default = "chromium";
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
