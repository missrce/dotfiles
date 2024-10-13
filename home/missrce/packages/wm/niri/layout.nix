{osConfig, lib, ...}:
let
  inherit (osConfig.catppuccin) sources flavor accent;

  palette = (lib.importJSON "${sources.palette}/palette.json").${flavor}.colors;
in {
  border = {
    enable = true;
    width = 0.1;
    active.color = palette.${accent}.hex;
    inactive.color = palette.mantle.hex;
  };
  focus-ring.enable = false;
}
