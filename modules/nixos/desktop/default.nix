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
    ./niri
    ./GNOME
  ];

  options.missos.environment = {
    desktop = mkOption {
      type = nullOr (enum [
        "none"
        "GNOME"
        "niri"
      ]);
      default =
        if config.missos.system.interface.graphical
        then "GNOME"
        else "none";
      description = "The desktop to be used by the system.";
    };

    isWM =
      mkEnableOption "Inferred based on the desktop environment."
      // {
        default = cfg.desktop == "niri";
      };
  };
}
