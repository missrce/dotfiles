{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (osConfig.catppuccin) sources flavor;

  palette = (lib.importJSON "${sources.palette}/palette.json").${flavor}.colors;
in {
  home.packages = [
    (pkgs.symlinkJoin {
      name = "freeze";
      paths = builtins.attrValues { inherit (pkgs) charm-freeze librsvg; };
    })
  ];

  xdg.configFile."freeze/user.json".text = builtins.toJSON {
    theme = "catppuccin-${flavor}";
    background = palette.base.hex;

    window = true;
    shadow = false;
    padding = [
      20
      40
      20
      20
    ];
    margin = 0;

    line_height = 1.2;
    line_numbers = true;

    font = {
      family = builtins.elemAt osConfig.fonts.fontconfig.defaultFonts.monospace 0;
      size = 14;
    };
  };
}
