{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.missos) system environment;
in {
  programs.hyprlock = mkIf (system.interface.graphical && environment.desktop == "Hyprland") {
    enable = true;

    extraConfig = ''
      background {
        monitor =
        color = $base
      }

      input-field {
        monitor =
        placeholder_text = <i>:3</i>

        size = 400, 50
        outline_thickness = 2
        dots_size = 0.2
        dots_center = true
        fade_on_empty = true

        position = 0, 0
        halign = center
        valign = center

        outer_color = $accent
        inner_color = $surface0
        font_color = $text
        check_color = $peach
        fail_color = $red

        fail_timeout = 500
      }
    '';

    catppuccin.enable = true;
  };
}
