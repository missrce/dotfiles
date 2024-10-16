{
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  inherit (osConfig.missos.system.interface) graphical;
in {
  programs.foot = mkIf graphical {
    enable = true;
    settings = {
      main.font = "${builtins.elemAt osConfig.fonts.fontconfig.defaultFonts.monospace 0}:size=11";
    };
  };
}
