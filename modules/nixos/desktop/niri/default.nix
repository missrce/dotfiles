{
  inputs,
  inputs',
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.missos.environment) desktop;
in {
  imports = [
    inputs.niri.nixosModules.niri
  ];

  config = {
    niri-flake.cache.enable = false;
  } // mkIf (desktop == "niri") {
    programs.niri = {
      enable = true;
      package = inputs'.niri.packages.niri-unstable;
    };

    environment.sessionVariables = {
      "NIXOS_OZONE_WL" = "1";

      "XDG_CURRENT_DESKTOP" = "niri";
      "XDG_SESSION_DESKTOP" = "niri";
      "XDG_SESSION_TYPE" = "wayland";

      "QT_AUTO_SCREEN_SCALE_FACTOR" = "1";
      "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";

      "GDK_BACKEND" = "wayland,x11";
      "SDL_VIDEODRIVER" = "wayland";
      "CLUTTER_BACKEND" = "wayland";
    };
  };
}
