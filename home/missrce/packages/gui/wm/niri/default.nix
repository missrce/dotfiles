{
  osConfig,
  inputs,
  config,
  lib,
  ...
}@attrs: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.missos.environment) desktop;
in {
  imports = [inputs.homeModules.niri];
  
  programs.niri = mkIf (desktop == "niri") {
    settings = {
      prefer-no-csd = true;
      screenshot-path = "${config.xdg.userDirs.extraConfig.XDG_SCREENSHOT_DIR}";

      binds = import ./binds.nix attrs;
    };
  };
}
