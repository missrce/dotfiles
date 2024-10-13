{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.missos.environment) desktop;
in {
  programs.niri = mkIf (desktop == "niri") {
    settings = {
      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = true;
      screenshot-path = "${config.xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR}/screenshot-%d-%m-%Y-%H:%M:%S.png";
      animations.slowdown = 0.7;

      input = import ./input.nix;
      layout = import ./layout.nix {inherit osConfig lib;};
      binds = import ./binds.nix {inherit osConfig config pkgs lib;};
      window-rules = import ./rules.nix;
    };
  };
}
