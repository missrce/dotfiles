{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.services) mkGraphicalService;
in {
  home.sessionVariables = {
    DISPLAY = ":0"; # The default output for xwayland-satellite
  };
  systemd.user.services.xwayland-satellite = mkGraphicalService {
    Unit.Description = "Rootless Xwayland integration to any Wayland compositor implementing xdg_wm_base";
    Service = {
      ExecStart = "${pkgs.xwayland-satellite}";
      Restart = "always";
    };
  };
}