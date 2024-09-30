{config, lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr enum;
in {
  imports = [
    ./Hyprland
  ];

  options.missos.environment.desktop = mkOption {
    type = nullOr (enum [
      "none"
      "Hyprland"
    ]);
    default = if config.missos.system.interface.graphical then "Hyprland" else "none";
    description = "The desktop to be used by the system.";
  };
}
