{
  lib,
  inputs,
  osConfig,
  ...
}: let
  inherit (osConfig.missos.system.interface) graphical;
  inherit (osConfig.catppuccin) accent flavor;
in {
  imports = [inputs.catppuccin.homeManagerModules.catppuccin];

  config = {
    catppuccin = {
      inherit flavor accent;

      enable = true;

      pointerCursor = {
        enable = graphical;
      };
    };

    # pointer / cursor theming
    home.pointerCursor = lib.modules.mkIf graphical {
      size = 16;
      gtk.enable = true;
      # this adds extra deps, so lets only enable it on wayland
      x11.enable = true;
    };
  };
}
