{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (osConfig.catppuccin) sources flavor accent;

  palette = (lib.importJSON "${sources.palette}/palette.json").${flavor}.colors;
in {
  home.packages = [
    (pkgs.symlinkJoin {
      name = "freeze";
      paths = builtins.attrValues {inherit (pkgs) charm-freeze librsvg;};
    })
  ];

  xdg.configFile."freeze/user.json".text = builtins.toJSON {
    theme = "catppuccin-${flavor}";
    background = palette.base.hex;
    border = {
      radius = 4;
      width = 4;
      color = palette.${accent}.hex;
    };

    window = false;
    shadow = false;
    padding = [
      10
      20
      10
      10
    ];
    margin = 0;

    line_height = 1.2;
    line_numbers = true;

    font = {
      family = builtins.elemAt osConfig.fonts.fontconfig.defaultFonts.monospace 0;
      size = 11;
    };
  };

  home.shellAliases = {
    freeze = "freeze -c user";
  };
}
