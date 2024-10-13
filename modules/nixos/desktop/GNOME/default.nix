{config, pkgs, lib, ...}: let
  inherit (lib.modules) mkIf;

  inherit (config.missos.environment) desktop;
in {
  config = mkIf (desktop == "GNOME") {
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = with pkgs; [
      geary # I use Thunderbird
      epiphany # I do not use GNOME Web
      gnome-tour # I have used GNOME previously
      gnome-maps # I do not need this
      gnome-music # I do not use this I use other software
      gnome-contacts # Storing contacts on a PC probably isn't the most secure idea
      gnome-software # I do not install software imperatively
    ];
    
    environment.sessionVariables = {
      "NIXOS_OZONE_WL" = "1"; # Tell Electron based apps to use Wayland
    };
  };
}
