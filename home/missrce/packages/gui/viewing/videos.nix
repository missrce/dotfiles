{
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  inherit (osConfig.missos.system.interface) graphical;
in {
  config = mkIf graphical {
    programs.mpv.enable = true;

    xdg.mimeApps = let
      associations = {
        "video/*" = [
          "mpv.desktop"
        ];
      };
    in {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
