{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.missos) system environment;

  inherit (osConfig.catppuccin) sources flavor accent;

  palette = (lib.importJSON "${sources.palette}/palette.json").${flavor}.colors;

  rgbString = colorSet: "rgb(${toString colorSet.rgb.r}, ${toString colorSet.rgb.g}, ${toString colorSet.rgb.b})";
in {
  programs.hyprlock = mkIf (system.interface.graphical && environment.desktop == "Hyprland") {
    enable = true;

    settings = {
      background = [
        {
          color = rgbString palette.base;
        }
      ];

      input-field = [
        {
          placeholder_text = "<i>:3</i>";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_timeout = 500;

          size = "400, 50";
          position = "0, 0";
          halign = "center";
          valign = "center";

          outline_tickness = 2;
          dots_center = true;
          dots_size = 0.2;
          fade_on_empty = true;
          outer_color = rgbString palette.${accent};
          inner_color = rgbString palette.surface0;
          font_color = rgbString palette.text;
          check_color = rgbString palette.peach;
          fail_color = rgbString palette.red;
        }
      ];
    };
  };
}
