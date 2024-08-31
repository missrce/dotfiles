{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption;
  inherit (lib.types) bool;
in {
  options.missos = {
    device.hasSound = mkOption {
      type = bool;
      default = false;
      description = "Whether or not the system has audio support";
    };
  };

  config = mkIf config.missos.device.hasSound {
    environment.systemPackages = with pkgs;
      [
        pulseaudio
      ]
      ++ mkIf config.missos.system.interface.graphical [
        pkgs.pavucontrol
      ];
    sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
