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
      prefer-no-csd = true;
      screenshot-path = "${config.xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR}\/screenshot-%d\/%m\/%Y-%H:%M-%S.png";

      input = {focus-follows-mouse.enable = true;};
      binds = import ./binds.nix {inherit osConfig config pkgs lib;};
    };
  };
}
