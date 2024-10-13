{
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  programs.foot = mkIf (osConfig.missos.programs.terminal == "foot") {
    enable = true;
    settings = {
      main.font = "${builtins.elemAt osConfig.fonts.fontconfig.defaultFonts.monospace 0}:size=11";
      cursor.style = "beam";
    };
  };
}
