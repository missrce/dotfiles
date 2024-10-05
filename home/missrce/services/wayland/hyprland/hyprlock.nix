{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.missos) system environment;

  inherit (osConfig.catppuccin) sources flavor accent;

  palette = (lib.importJSON "${sources.palette}/palette.json").${flavor}.colors;
in {
  programs.hyprlock = mkIf (system.interface.graphical && environment.desktop == "Hyprland") {
    enable = true;

    settings = {
      background = [
        {
          color = palette.base;
        }
      ];

      input-field = [
        {
          placeholder_text = ":3";
          fail_text = "$FAIL";
          fail_timeout = 500;

          size = "400, 50";
          position = "0, 0";
          halign = "center";
          valign = "center";

          outline_tickness = 2;
          dots_center = true;
          dots_size = 0.2;
          fade_on_empty = true;
          outer_color = palette.${accent};
          inner_color = palette.surface0;
          font_color = palette.text;
          check_color = palette.peach;
          fail_color = palette.red;
        }
      ];
    };
  };
}
