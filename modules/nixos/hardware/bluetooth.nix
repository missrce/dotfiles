{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) bool;

  sys = config.missos.system;
in {
  options.missos = {
    device.hasBluetooth = mkOption {
      type = bool;
      default = false;
      description = "Whether or not the system has bluetooth support";
    };

    system.bluetooth.enable = mkEnableOption "Should the device load bluetooth drivers and enable blueman";
  };

  config = mkIf sys.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    # https://wiki.nixos.org/wiki/Bluetooth
    services.blueman.enable = true;
  };
}
