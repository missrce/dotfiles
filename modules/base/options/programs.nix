{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.missos.programs = {
    browser = {
      chromium = mkEnableOption "Chromium browser";
      firefox = mkEnableOption "Mozilla Firefox browser";
    };
  };
}
