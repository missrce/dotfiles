{
  lib,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (osConfig.missos) system environment;
in {
  services.hypridle = mkIf (system.interface.graphical && environment.desktop == "Hyprland") {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        {
          timeout = 180;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 240;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
