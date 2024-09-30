{ inputs, pkgs, ...}: {
  config = {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };

    environment.sessionVariables = {
      "NIXOS_OZONE_WL" = "1"; # Tell Electron based apps to use Wayland

      "XDG_CURRENT_DESKTOP" = "Hyprland";
      "XDG_SESSION_DESKTOP" = "Hyprland";
      "XDG_SESSION_TYPE" = "wayland";

      "QT_AUTO_SCREEN_SCALE_FACTOR" = "1";
      "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";

      "GDK_BACKEND" = "wayland,x11";
      "SDL_VIDEODRIVER" = "wayland";
      "CLUTTER_BACKEND" = "wayland";
    };
  };
}
