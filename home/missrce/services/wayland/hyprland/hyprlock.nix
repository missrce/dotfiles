{
  lib,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (osConfig.missos) system environment;
in {
  programs.hyprlock = mkIf (system.interface.graphical && environment.desktop == "Hyprland") {
    enable = true;

    catppuccin.enable = true;
  };
}
