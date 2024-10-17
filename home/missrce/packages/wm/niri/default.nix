{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.missos) environment device;
in {
  programs.niri = mkIf (environment.desktop == "niri") {
    settings = {
      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = true;
      screenshot-path = "${config.xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR}/screenshot-%d-%m-%Y-%H:%M:%S.png";
      animations.slowdown = 0.7;
      debug.render-drm-device = device.primaryRenderDevice;

      input = import ./input.nix;
      layout = import ./layout.nix {inherit osConfig lib;};
      binds = import ./binds.nix {inherit osConfig config pkgs lib;};
      window-rules = import ./rules.nix;
    };
  };
}
