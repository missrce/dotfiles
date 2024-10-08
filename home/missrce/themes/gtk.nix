{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.validators) isAcceptedDevice;

  inherit (osConfig.missos.system.interface) graphical;

  acceptedTypes = [
    "laptop"
    "desktop"
  ];
in {
  config = mkIf (isAcceptedDevice osConfig acceptedTypes && graphical) {
    xdg.systemDirs.data = let
      schema = pkgs.gsettings-desktop-schemas;
    in ["${schema}/share/gsettings-schemas/${schema.name}"];

    home = {
      packages = [
        pkgs.glib # gsettings
      ];

      # gtk applications should use xdg specified settings
      sessionVariables.GTK_USE_PORTAL = "1";
    };

    gtk = {
      enable = true;

      catppuccin = {
        enable = true;
        icon.enable = true;
        tweaks = ["float"];

        gnomeShellTheme = true;
      };

      font = {
        name = builtins.elemAt osConfig.fonts.fontconfig.defaultFonts.sansSerif 0;
        size = 11;
      };

      gtk2 = {
        configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        extraConfig = ''
          gtk-xft-antialias=1
          gtk-xft-hinting=1
          gtk-xft-hintstyle="hintslight"
          gtk-xft-rgba="rgb"
        '';
      };

      gtk3.extraConfig = {
        # make things look nice
        gtk-decoration-layout = "appmenu:none";

        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";

        # stop annoying sounds
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-error-bell = 0;

        # config that is not the same as gtk4
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";

        gtk-button-images = 1;
        gtk-menu-images = 1;
      };

      gtk4.extraConfig = {
        # make things look nice
        gtk-decoration-layout = "appmenu:none";

        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";

        # stop annoying sounds again
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-error-bell = 0;
      };
    };
  };
}
