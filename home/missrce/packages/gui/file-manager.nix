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
    home.packages = [
      pkgs.nautilus
    ];

    xdg.mimeApps = let
      associations = {
        "inode/directory" = [
          "org.gnome.Nautilus.desktop"
        ];
      };
    in {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
