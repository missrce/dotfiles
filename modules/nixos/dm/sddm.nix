{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (config.missos) environment;
  inherit (lib.modules) mkIf;
in {
  config = mkIf (environment.loginManager == "sddm") {
    systemd.services.display-manager.preStart = ''${pkgs.coreutils}/bin/sleep 0.5'';
    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm; # allow qt6 themes to work
      wayland.enable = true; # run under wayland rather than X11
      settings.General.InputMethod = "";
    };
  };
}
