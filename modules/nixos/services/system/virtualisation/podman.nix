{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.missos.system.virtualisation.podman;
in {
  options.missos.system.virtualisation.podman.enable = mkEnableOption "Enable podman";

  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      autoPrune = {
        enable = true;
        flags = ["--all"];
      };
      dockerCompat = true;
      dockerSocket.enable = true;
    };
  };
}
