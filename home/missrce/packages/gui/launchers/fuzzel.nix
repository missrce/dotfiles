{
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  programs.fuzzel = mkIf (osConfig.missos.programs.launcher == "fuzzel") {
    enable = true;
    settings = {
      main.font = "${builtins.elemAt osConfig.fonts.fontconfig.defaultFonts.sansSerif 0}:size=9";
    };
  };
}