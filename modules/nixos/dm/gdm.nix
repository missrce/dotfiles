{
  config,
  lib,
  ...
}: let
  inherit (config.missos.environment) loginManager;
  inherit (lib.modules) mkIf;
in {
  services.xserver = mkIf (loginManager == "gdm") {
    displayManager.gdm = {
      enable = true;
      wayland = true;
      banner = ''>:3c'';
    };
  };
}
