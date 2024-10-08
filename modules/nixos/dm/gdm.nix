{
  config,
  lib,
  ...
}: let
  inherit (config.missos.environment) loginManager;
  inherit (lib.modules) mkIf;
in {
  services.xserver = mkIf (loginManager == "gdm") {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
      banner = ''>:3c'';
    };
  };
}
