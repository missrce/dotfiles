{
  pkgs,
  config,
  ...
}: let
  inherit (config.missos) environment;
in {
  systemd.services.display-manager.wants = [
    "systemd-user-sessions.service"
    "multi-user.target"
    "network-online.target"
  ];
  services.displayManager.sddm = {
    enable = environment.loginManager == "sddm";
    package = pkgs.kdePackages.sddm; # allow qt6 themes to work
    wayland.enable = true; # run under wayland rather than X11
    settings.General.InputMethod = "";
  };
}
