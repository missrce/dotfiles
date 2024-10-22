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
    home.packages = with pkgs; [gapless];

    xdg.mimeApps = let
      associations = {
        "audio/*" = [
          "com.github.neithern.g4music.desktop"
        ];
      };
    in {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
