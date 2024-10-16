{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.lists) optionals;

  inherit (osConfig.missos.system.interface) graphical;
in {
  home.packages = optionals graphical [
    pkgs.prismlauncher
  ];
}
