{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  inherit (osConfig.missos.system.interface) graphical;
in {
  config = mkIf graphical {
    home.packages = with pkgs; [ loupe ];

    xdg.mimeApps = let
      associations = {
        "image/*" = [
          "org.gnome.Loupe.desktop"
        ];
      };
    in {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
