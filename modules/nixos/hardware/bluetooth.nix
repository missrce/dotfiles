{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption;
  inherit (lib.types) bool;
  inherit (lib.lists) optionals;
in {
  options.missos = {
    device.hasBluetooth = mkOption {
      type = bool;
      default = false;
      description = "Whether or not the system has bluetooth support";
    };
  };

  config = mkIf config.missos.device.hasBluetooth {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    # https://wiki.nixos.org/wiki/Bluetooth
    services.blueman.enable = true;

    environment.systemPackages = optionals config.missos.system.interface.graphical [
      pkgs.overskride
    ];
  };
}
