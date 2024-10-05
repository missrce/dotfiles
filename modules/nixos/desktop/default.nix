{
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) nullOr enum;

  cfg = config.missos.environment;
in {
  imports = [
    ./Hyprland
  ];

  options.missos.environment = {
    desktop = mkOption {
      type = nullOr (enum [
        "none"
        "Hyprland"
        "sway"
      ]);
      default =
        if config.missos.system.interface.graphical
        then "Hyprland"
        else "none";
      description = "The desktop to be used by the system.";
    };

    isWM =
      mkEnableOption "Inferred based on the desktop environment."
      // {
        default = cfg.desktop == "Hyprland" || cfg.desktop == "sway";
      };
  };
}
