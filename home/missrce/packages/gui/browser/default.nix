{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  imports = [
    ./chromium.nix
  ];

  options.missos.programs.browser = {
    chromium = mkEnableOption "Chromium browser";
    firefox = mkEnableOption "Mozilla Firefox browser";
  };
}
